import 'dart:convert';
import 'package:alamuti/app/controller/chat_group_controller.dart';
import 'package:alamuti/app/controller/group_list_index.dart';
import 'package:alamuti/app/controller/new_message_controller.dart';
import 'package:alamuti/app/controller/selectedTapController.dart';
import 'package:alamuti/app/data/model/chatgroup.dart';
import 'package:alamuti/app/data/provider/chat_message_provider.dart';
import 'package:alamuti/app/data/provider/signalr_helper.dart';
import 'package:alamuti/app/data/storage/cachemanager.dart';
import 'package:alamuti/app/ui/chat/chat.dart';
import 'package:alamuti/app/ui/home/home_page.dart';
import 'package:alamuti/app/ui/theme.dart';
import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:alamuti/app/ui/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChatGroups extends StatelessWidget with CacheManager {
  ChatGroups({Key? key}) : super(key: key);
  var newMessageController = Get.put(NewMessageController());
  var indexGroupList = Get.put(IndexGroupList());
  var chatGroupController = Get.put(ChatGroupController());
  var screenController = Get.put(ScreenController());

  SignalRHelper signalHelper = SignalRHelper();
  var mp = MessageProvider();
  var storage = GetStorage();
  @override
  Widget build(BuildContext context) {
    signalHelper.initiateConnection();
    signalHelper.reciveMessage();
    var _scrollcontroller = ScrollController();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      screenController.selectedIndex.value = 1;
    });

    signalHelper.createGroup(
      storage.read(CacheManagerKey.USERID.toString()),
    );

    return Scaffold(
      appBar: AlamutiAppBar(
        appBar: AppBar(),
        title: 'چت الموتی',
        backwidget: HomePage(),
        hasBackButton: false,
      ),
      bottomNavigationBar: AlamutBottomNavBar(),
      body: FutureBuilder(
        future: mp.getGroups(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.greenAccent,
              ),
            );
          } else {
            return Obx(
              () => ListView.builder(
                controller: _scrollcontroller,
                itemCount: chatGroupController.groupList.length,
                itemBuilder: (context, index) {
                  indexGroupList.changeIndex(index);

                  return GestureDetector(
                    onLongPress: () {
                      Get.defaultDialog(
                        radius: 5,
                        title: 'از حذف چت مطمئن هستید ؟ ',
                        barrierDismissible: false,
                        titlePadding: EdgeInsets.all(20),
                        titleStyle: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                        content: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'پیامهای مربوط به این کاربر حذف میشوند',
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        cancel: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              'انصراف',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                  color: Colors.green),
                            ),
                          ),
                        ),
                        confirm: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextButton(
                              onPressed: () async {
                                await mp.deleteMessageGroup(
                                  groupName:
                                      chatGroupController.groupList[index].name,
                                );
                                Get.back();
                              },
                              child: Text(
                                'حذف',
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                    color: Colors.red),
                              )),
                        ),
                      );
                    },
                    onTap: () async {
                      if (await getUserId() !=
                          chatGroupController
                              .groupList[index].lastMessage.sender) {
                        mp.updateGroupStatus(
                            name: chatGroupController.groupList[index].name,
                            id: chatGroupController.groupList[index].id,
                            title: chatGroupController.groupList[index].title,
                            isChecked: true);
                      }

                      newMessageController.haveNewMessage.value = false;

                      chatGroupController.groupList.forEach(
                        (element) {
                          signalHelper.leaveGroup((element as ChatGroup).name);
                        },
                      );

                      Get.to(
                          () => Chat(
                                groupname:
                                    chatGroupController.groupList[index].name,
                                groupTitle:
                                    chatGroupController.groupList[index].title,
                                groupImage: chatGroupController
                                    .groupList[index].groupImage,
                              ),
                          transition: Transition.fadeIn);
                    },
                    child: Obx(
                      () => Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Obx(
                            () => Card(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(Get.height / 50),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      chatGroupController
                                          .groupList[index].lastMessage.message,
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          fontWeight: (chatGroupController
                                                          .groupList[index]
                                                          .isChecked ==
                                                      false &&
                                                  chatGroupController
                                                          .groupList[index]
                                                          .lastMessage
                                                          .sender !=
                                                      getUserId())
                                              ? FontWeight.w500
                                              : FontWeight.w300,
                                          fontSize: 13),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: Get.height / 80,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          chatGroupController
                                              .groupList[index].title,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: persianNumber,
                                              fontSize: 12),
                                        ),
                                        SizedBox(
                                          width: Get.width / 30,
                                        ),
                                        FittedBox(
                                          fit: BoxFit.fill,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: (chatGroupController
                                                        .groupList[index]
                                                        .groupImage !=
                                                    null)
                                                ? Image.memory(
                                                    base64Decode(
                                                        chatGroupController
                                                            .groupList[index]
                                                            .groupImage),
                                                    filterQuality:
                                                        FilterQuality.low,
                                                    fit: BoxFit.cover,
                                                    width: Get.width / 7,
                                                    height: Get.width / 7,
                                                  )
                                                : (chatGroupController
                                                            .groupList[index]
                                                            .title ==
                                                        'الموتی'
                                                    ? Image.asset(
                                                        'assets/logo/logo.png',
                                                        fit: BoxFit.fitWidth,
                                                        width: Get.width / 7,
                                                        height: Get.width / 7,
                                                      )
                                                    : Image.asset(
                                                        'assets/logo/no-image.png',
                                                        fit: BoxFit.cover,
                                                        width: Get.width / 7,
                                                        height: Get.width / 7,
                                                      )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                chatGroupController
                                    .groupList[index].lastMessage.daySended,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontFamily: persianNumber,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                          (chatGroupController.groupList[index].isChecked ==
                                      false &&
                                  chatGroupController.groupList[index]
                                          .lastMessage.sender !=
                                      (getUserId()))
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 40),
                                  child: Obx(
                                    () => Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        color: (chatGroupController
                                                        .groupList[index]
                                                        .isChecked ==
                                                    false &&
                                                chatGroupController
                                                        .groupList[index]
                                                        .lastMessage
                                                        .sender !=
                                                    (getUserId()))
                                            ? Colors.green.withOpacity(0.25)
                                            : Colors.transparent,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(2),
                                        child: Obx(
                                          () => Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: (chatGroupController
                                                              .groupList[index]
                                                              .isChecked ==
                                                          false &&
                                                      chatGroupController
                                                              .groupList[index]
                                                              .lastMessage
                                                              .sender !=
                                                          (getUserId()))
                                                  ? Colors.red
                                                  : Colors.transparent,
                                            ),
                                            child: Container(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(color: Colors.transparent)
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
