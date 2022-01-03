import 'dart:convert';
import 'package:alamuti/app/controller/chat_group_controller.dart';
import 'package:alamuti/app/controller/chat_message_controller.dart';
import 'package:alamuti/app/controller/chat_target_controller.dart';
import 'package:alamuti/app/controller/group_list_index.dart';
import 'package:alamuti/app/controller/last_message_sender_controller.dart';
import 'package:alamuti/app/controller/new_message_controller.dart';
import 'package:alamuti/app/controller/senderController.dart';
import 'package:alamuti/app/data/model/chatgroup.dart';
import 'package:alamuti/app/data/provider/chat_message_provider.dart';
import 'package:alamuti/app/data/provider/signalr_helper.dart';
import 'package:alamuti/app/data/storage/cachemanager.dart';
import 'package:alamuti/app/ui/chat/chat.dart';
import 'package:alamuti/app/ui/home/home_page.dart';
import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:alamuti/app/ui/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChatGroups extends StatefulWidget with CacheManager {
  const ChatGroups({Key? key}) : super(key: key);

  @override
  State<ChatGroups> createState() => _ChatGroupsState();
}

class _ChatGroupsState extends State<ChatGroups> with CacheManager {
  var textEditingController = TextEditingController();
  late SignalRHelper signalHelper;
  var _scrollcontroller = ScrollController();

  var chatTargetUserController = Get.put(ChatTargetUserController());

  var chatMessageController = Get.put(ChatMessageController());

  var chatGroupController = Get.put(ChatGroupController());

  var newMessageController = Get.put(NewMessageController());

  var senderController = Get.put(SenderController());

  var lastMessageSenderIDController = Get.put(LastMessageSenderIDController());

  var indexGroupList = Get.put(IndexGroupList());

  var storage = GetStorage();
  var groupIndex = 0;

  var mp = MessageProvider();

  List<ChatGroup> groupList = [];

  getGroups() async {
    return await mp.getGroups();
  }

  @override
  void initState() {
    super.initState();
    signalHelper = SignalRHelper();
    signalHelper.initiateConnection();
    signalHelper.reciveMessage();
  }

  @override
  Widget build(BuildContext context) {
    signalHelper.createGroup(
      storage.read(CacheManagerKey.USERID.toString()),
    );
    chatMessageController.messageList.listen((p0) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        if (_scrollcontroller.hasClients) {
          _scrollcontroller.jumpTo(_scrollcontroller.position.maxScrollExtent);
        }
      });
    });

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      signalHelper.createGroup(
        storage.read(CacheManagerKey.USERID.toString()),
      );
      if (_scrollcontroller.hasClients) {
        _scrollcontroller.jumpTo(_scrollcontroller.position.maxScrollExtent);
      }
    });

    return Scaffold(
        appBar: AlamutiAppBar(
          appBar: AppBar(),
          title: 'چت الموتی',
          backwidget: HomePage(),
          hasBackButton: false,
        ),
        bottomNavigationBar: AlamutBottomNavBar(),
        body: FutureBuilder(
          future: getGroups(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Obx(() => ListView.builder(
                    controller: _scrollcontroller,
                    itemCount: chatGroupController.groupList.length,
                    itemBuilder: (context, index) {
                      Future<String> sender() async {
                        return await mp.getLastItemOfGroup(
                            chatGroupController.groupList[index].name);
                      }

                      indexGroupList.changeIndex(index);

                      return GestureDetector(
                        onLongPress: () {
                          print(chatGroupController.groupList[index].name);
                          Get.defaultDialog(
                            radius: 5,
                            title: 'از حذف چت مطمئن هستید ؟ ',
                            barrierDismissible: false,
                            titlePadding: EdgeInsets.all(20),
                            titleStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                            content: Text(
                              'پیامهای مربوط به این کاربر حذف میشوند',
                              style: TextStyle(
                                fontWeight: FontWeight.w200,
                                fontSize: 14,
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
                                  )),
                            ),
                            confirm: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextButton(
                                  onPressed: () async {
                                    await mp.deleteMessageGroup(
                                      groupName: chatGroupController
                                          .groupList.value[index].name,
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
                          if (await getUserId() != await sender()) {
                            mp.updateGroupStatus(
                                name: chatGroupController
                                    .groupList.value[index].name,
                                id: chatGroupController.groupList[index].id,
                                title:
                                    chatGroupController.groupList[index].title,
                                isChecked: true);
                          }

                          newMessageController.haveNewMessage.value = false;

                          chatGroupController.groupList.forEach((element) {
                            signalHelper
                                .leaveGroup((element as ChatGroup).name);
                          });

                          Get.to(
                              () => Chat(
                                    groupname: chatGroupController
                                        .groupList[index].name,
                                    groupTitle: chatGroupController
                                        .groupList[index].title,
                                    groupImage: chatGroupController
                                        .groupList[index].groupImage,
                                  ),
                              transition: Transition.noTransition);
                        },
                        child: Obx(
                          () =>
                              Stack(alignment: Alignment.bottomLeft, children: [
                            Obx(() => Card(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.all(Get.height / 50),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          chatGroupController.groupList
                                              .value[index].lastMessage.message,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              chatGroupController
                                                  .groupList[index].title,
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'IRANSansXFaNum',
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
                                                                .groupList[
                                                                    index]
                                                                .groupImage),
                                                        fit: BoxFit.cover,
                                                        width: Get.width / 7,
                                                        height: Get.width / 7,
                                                      )
                                                    : (chatGroupController
                                                                .groupList[
                                                                    index]
                                                                .title ==
                                                            'الموتی'
                                                        ? Image.asset(
                                                            'assets/logo/logo.png',
                                                            fit:
                                                                BoxFit.fitWidth,
                                                            width:
                                                                Get.width / 7,
                                                            height:
                                                                Get.width / 7,
                                                          )
                                                        : Image.asset(
                                                            'assets/logo/no-image.png',
                                                            fit: BoxFit.cover,
                                                            width:
                                                                Get.width / 7,
                                                            height:
                                                                Get.width / 7,
                                                          )),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
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
                                      fontFamily: 'IRANSansXFaNum',
                                      fontSize: 12),
                                ),
                              ),
                            ),
                            (chatGroupController.groupList[index].isChecked ==
                                        false &&
                                    chatGroupController.groupList[index]
                                            .lastMessage.sender !=
                                        getUserId())
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 40),
                                    child: Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.25),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(2),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.red,
                                          ),
                                          child: Container(),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    color: Colors.transparent,
                                  )
                          ]),
                        ),
                      );
                    },
                  ));
            }
          },
        ));
  }
}
