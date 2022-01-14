import 'dart:convert';
import 'package:alamuti/app/controller/chat_group_controller.dart';
import 'package:alamuti/app/controller/new_message_controller.dart';
import 'package:alamuti/app/controller/selected_tap_controller.dart';
import 'package:alamuti/app/data/model/chatgroup.dart';
import 'package:alamuti/app/data/provider/chat_message_provider.dart';
import 'package:alamuti/app/data/provider/signalr_helper.dart';
import 'package:alamuti/app/data/storage/cache_manager.dart';
import 'package:alamuti/app/ui/chat/chat.dart';
import 'package:alamuti/app/ui/theme.dart';
import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:alamuti/app/ui/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChatGroups extends StatelessWidget with CacheManager {
  ChatGroups({Key? key}) : super(key: key);

  final NewMessageController newMessageController = Get.find();

  final ChatGroupController chatGroupController = Get.find();

  final ScreenController screenController = Get.find();

  final SignalRHelper signalHelper = SignalRHelper();

  final MessageProvider messageProvider = MessageProvider();

  final GetStorage storage = GetStorage();

  final ScrollController _scrollcontroller = ScrollController();

  final double width = Get.width;

  final double height = Get.height;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      screenController.selectedIndex.value = 1;
    });
    messageProvider.getGroups();
    chatGroupController.groupList.listen((p0) {
      WidgetsBinding.instance?.addPostFrameCallback((_) async {
        await signalHelper.initiateConnection();

        chatGroupController.groupList.forEach((element) {
          signalHelper.createGroup(
            element.name,
          );
        });
        await signalHelper.reciveMessage();
      });
    });

    return Scaffold(
      appBar: AlamutiAppBar(
        appBar: AppBar(),
        title: 'پیامها',
        hasBackButton: false,
      ),
      bottomNavigationBar: AlamutBottomNavBar(),
      body: Obx(
        () => ListView.builder(
          controller: _scrollcontroller,
          itemCount: chatGroupController.groupList.length,
          itemBuilder: (context, index) {
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
                          await messageProvider.deleteMessageGroup(
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
                newMessageController.haveNewMessage.value = false;
                if (await getUserId() ==
                    chatGroupController.groupList[index].lastMessage.reciever) {
                  messageProvider.updateGroupStatus(
                      name: chatGroupController.groupList[index].name,
                      id: chatGroupController.groupList[index].id,
                      title: chatGroupController.groupList[index].title,
                      isChecked: true);
                }

                chatGroupController.groupList.forEach(
                  (element) {
                    signalHelper.leaveGroup((element as ChatGroup).name);
                  },
                );

                Get.to(
                  () => Chat(
                    groupname: chatGroupController.groupList[index].name,
                    groupTitle: chatGroupController.groupList[index].title,
                    groupImage: chatGroupController.groupList[index].groupImage,
                  ),
                  transition: Transition.fadeIn,
                );
              },
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(height / 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            chatGroupController
                                .groupList[index].lastMessage.message,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                fontWeight: (chatGroupController
                                                .groupList[index].isChecked ==
                                            false &&
                                        chatGroupController.groupList[index]
                                                .lastMessage.reciever ==
                                            storage.read(
                                              CacheManagerKey.USERID.toString(),
                                            ))
                                    ? FontWeight.w500
                                    : FontWeight.w300,
                                fontSize: 13),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: height / 80,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                chatGroupController.groupList[index].title,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: persianNumber,
                                    fontSize: 12),
                              ),
                              SizedBox(
                                width: width / 30,
                              ),
                              FittedBox(
                                fit: BoxFit.fill,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: (chatGroupController
                                              .groupList[index].groupImage !=
                                          null)
                                      ? Image.memory(
                                          base64Decode(chatGroupController
                                              .groupList[index].groupImage),
                                          filterQuality: FilterQuality.low,
                                          fit: BoxFit.cover,
                                          width: width / 7,
                                          height: width / 7,
                                        )
                                      : (chatGroupController
                                                  .groupList[index].title ==
                                              'الموتی'
                                          ? Image.asset(
                                              'assets/logo/logo.png',
                                              fit: BoxFit.fitWidth,
                                              width: width / 7,
                                              height: width / 7,
                                            )
                                          : Image.asset(
                                              'assets/logo/no-image.png',
                                              fit: BoxFit.cover,
                                              width: width / 7,
                                              height: width / 7,
                                            )),
                                ),
                              )
                            ],
                          ),
                        ],
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
                  (chatGroupController.groupList[index].isChecked == false &&
                          chatGroupController
                                  .groupList[index].lastMessage.reciever ==
                              storage.read(
                                CacheManagerKey.USERID.toString(),
                              ))
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 40),
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color:
                                  // (chatGroupController
                                  //                 .groupList[index].isChecked ==
                                  //             false &&
                                  //         chatGroupController.groupList[index]
                                  //                 .lastMessage.reciever ==
                                  //             getUserId())
                                  //     ?
                                  Colors.green.withOpacity(0.25),
                              // : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(2),
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        // (chatGroupController.groupList[index]
                                        //                 .isChecked ==
                                        //             false &&
                                        //         chatGroupController.groupList[index]
                                        //                 .lastMessage.reciever ==
                                        //             getUserId())
                                        //     ?
                                        Colors.red
                                    // : Colors.transparent,
                                    ),
                                child: Container(),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          color: Colors.transparent,
                        )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
