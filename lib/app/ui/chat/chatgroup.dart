import 'package:alamuti/app/controller/chat_group_controller.dart';
import 'package:alamuti/app/controller/chat_message_controller.dart';
import 'package:alamuti/app/controller/chat_target_controller.dart';
import 'package:alamuti/app/controller/group_list_index.dart';
import 'package:alamuti/app/controller/last_message_sender_controller.dart';
import 'package:alamuti/app/controller/selectedTapController.dart';
import 'package:alamuti/app/controller/senderController.dart';
import 'package:alamuti/app/data/model/chatMessage.dart';
import 'package:alamuti/app/data/model/chatgroup.dart';
import 'package:alamuti/app/data/provider/chat_message_provider.dart';
import 'package:alamuti/app/data/provider/signalr_helper.dart';
import 'package:alamuti/app/data/storage/cachemanager.dart';
import 'package:alamuti/app/ui/chat/chat.dart';
import 'package:alamuti/app/ui/home/home_page.dart';
import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:alamuti/app/ui/widgets/alamuti_textfield.dart';
import 'package:alamuti/app/ui/widgets/appbar.dart';
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
  TextEditingController textEditingController = TextEditingController();
  late SignalRHelper signalHelper;
  var _scrollcontroller = ScrollController();

  ChatTargetUserController chatTargetUserController =
      Get.put(ChatTargetUserController());

  ScreenController screenController = Get.put(ScreenController());

  ChatMessageController chatMessageController =
      Get.put(ChatMessageController());

  ChatGroupController chatGroupController = Get.put(ChatGroupController());

  SenderController senderController = Get.put(SenderController());

  LastMessageSenderIDController lastMessageSenderIDController =
      Get.put(LastMessageSenderIDController());

  IndexGroupList indexGroupList = Get.put(IndexGroupList());
  // getresult() async {
  //   await mp.getLastItemOfGroup(
  //       chatGroupController.groupList[indexGroupList.index.value].name);
  // }

  var storage = GetStorage();
  bool issenderANDuserEqual = false;
  int groupIndex = 0;
  bool isResponse = false;
  var mp = MessageProvider();
  List<ChatGroup> groupList = [];

  getGroups() async {
    return await mp.getGroups();
  }

  @override
  void initState() {
    screenController.selectedIndex = 1;
    super.initState();
    signalHelper = SignalRHelper();
    signalHelper.initiateConnection();
    signalHelper.reciveMessage();
    //state is null at fisr after changing the state - hot relod will be fixed
  }

  @override
  Widget build(BuildContext context) {
    signalHelper.createGroup(
      storage.read(CacheManagerKey.USERID.toString()),
    );
    //state is null at fisr after changing the state - hot relod will be fixed
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
              return ListView.builder(
                controller: _scrollcontroller,
                itemCount: chatGroupController.groupList.length,
                itemBuilder: (context, index) {
                  Future<String> sender() async {
                    return await mp.getLastItemOfGroup(
                        chatGroupController.groupList[index].name);
                  }

                  indexGroupList.changeIndex(index);

                  return GestureDetector(
                      onTap: () async {
                        if (await getUserId() != await sender()) {
                          mp.updateGroupStatus(
                              name: chatGroupController.groupList[index].name,
                              id: chatGroupController.groupList[index].id,
                              title: chatGroupController.groupList[index].title,
                              isChecked: true);
                        }

                        chatGroupController.groupList.forEach((element) {
                          signalHelper.leaveGroup((element as ChatGroup).name);
                        });

                        // chatGroupController.groupList[index].name
                        //     .toString()
                        //     .indexOf(storage
                        //         .read(CacheManagerKey.USERID.toString()));
                        Get.to(
                            () => Chat(
                                groupname:
                                    chatGroupController.groupList[index].name,
                                groupTitle:
                                    chatGroupController.groupList[index].title,
                                messages: chatGroupController
                                    .groupList[index].messages),
                            transition: Transition.noTransition);
                      },
                      child: Card(
                        color:
                            (chatGroupController.groupList[index].isChecked ==
                                        false &&
                                    ChatMessage.fromJson(chatGroupController
                                                .groupList[index].messages.last)
                                            .sender !=
                                        getUserId())
                                ? Colors.red
                                : Colors.yellow,
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Column(
                            children: [
                              Text(
                                chatGroupController.groupList[index].title,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                              Text(
                                ChatMessage.fromJson(chatGroupController
                                        .groupList[index].messages.last)
                                    .message,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ));
                },
              );
            }
          },
        ));

    // return Scaffold(
    //   appBar: AlamutiAppBar(
    //     appBar: AppBar(),
    //     title: 'پیامها',
    //     hasBackButton: false,
    //   ),
    //   bottomNavigationBar: AlamutBottomNavBar(),
    //   body: Container(
    //     child: Center(
    //       child: Column(
    //         children: [
    //           Text(messageText),
    //           TextButton(
    //             onPressed: () {
    //               signalHelper.sendMessage(
    //                 chatTargetUserController.userId.value,
    //                 storage.read(
    //                   CacheManagerKey.USERID.toString(),
    //                 ),
    //                 'message',
    //               );
    //               print(storage.read(CacheManagerKey.USERID.toString()));
    //             },
    //             child: Text('send Hi'),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  void _onScroll() {
    if (_isBottom) {
      print('eeeeeeeeeeeeeeeend');
    } else {}
  }

  bool get _isBottom {
    final maxScroll = _scrollcontroller.position.maxScrollExtent;
    final currentScroll = _scrollcontroller.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
