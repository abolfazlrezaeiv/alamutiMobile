import 'package:alamuti/app/controller/chat_message_controller.dart';
import 'package:alamuti/app/controller/chat_target_controller.dart';
import 'package:alamuti/app/data/model/chatMessage.dart';
import 'package:alamuti/app/data/provider/chat_message_provider.dart';
import 'package:alamuti/app/data/provider/signalr_helper.dart';
import 'package:alamuti/app/data/storage/cachemanager.dart';
import 'package:alamuti/app/ui/chat/chatgroup.dart';
import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:alamuti/app/ui/widgets/alamuti_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_9.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NewChat extends StatefulWidget with CacheManager {
  final String receiverId;
  final String? groupImage;
  final String groupTitle;
  const NewChat(
      {Key? key,
      required this.groupTitle,
      required this.receiverId,
      required this.groupImage})
      : super(key: key);

  @override
  State<NewChat> createState() => _NewChatState();
}

class _NewChatState extends State<NewChat> {
  TextEditingController textEditingController = TextEditingController();
  late SignalRHelper signalHelper;
  var _scrollcontroller = ScrollController();

  ChatTargetUserController chatTargetUserController =
      Get.put(ChatTargetUserController());
  ChatMessageController chatMessageController =
      Get.put(ChatMessageController());

  MessageProvider mp = MessageProvider();

  var storage = GetStorage();

  bool isResponse = false;

  @override
  void initState() {
    super.initState();
    signalHelper = SignalRHelper();
    signalHelper.initiateConnection();
    signalHelper.reciveMessage();

    //state is null at fisr after changing the state - hot relod will be fixed
  }

  @override
  Widget build(BuildContext context) {
    //state is null at fisr after changing the state - hot relod will be fixed
    // signalHelper.createGroup(
    //   storage.read(CacheManagerKey.USERID.toString()),
    // );
    chatMessageController.messageList.listen((p0) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        if (_scrollcontroller.hasClients) {
          _scrollcontroller.jumpTo(_scrollcontroller.position.maxScrollExtent);
        }
      });
    });
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (_scrollcontroller.hasClients) {
        _scrollcontroller.jumpTo(_scrollcontroller.position.maxScrollExtent);
      }
    });
    return Scaffold(
      appBar: AlamutiAppBar(
        appBar: AppBar(),
        title: 'ارسال پیام',
        hasBackButton: true,
        backwidget: ChatGroups(),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: Obx(
            () => Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollcontroller,
                    itemCount: chatMessageController.messageList.length,
                    itemBuilder: (context, index) {
                      var storage = GetStorage();
                      if (chatMessageController
                              .messageList.value[index].sender ==
                          storage.read(CacheManagerKey.USERID.toString())) {
                        return ChatBubble(
                          clipper:
                              ChatBubbleClipper9(type: BubbleType.sendBubble),
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(top: 20),
                          backGroundColor: Color.fromRGBO(8, 212, 76, 0.5),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  chatMessageController
                                      .messageList.value[index].message,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(color: Colors.white),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      chatMessageController
                                          .messageList.value[index].daySended,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontFamily: 'IRANSansXFaNum',
                                          fontSize: 13),
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return ChatBubble(
                          clipper: ChatBubbleClipper9(
                              type: BubbleType.receiverBubble),
                          backGroundColor: Color(0xffE7E7ED),
                          margin: EdgeInsets.only(top: 20),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  chatMessageController
                                      .messageList.value[index].message,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(color: Colors.black),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      chatMessageController
                                          .messageList.value[index].daySended,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontFamily: 'IRANSansXFaNum',
                                          fontSize: 13),
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                Container(
                  color: Colors.grey.withOpacity(0.1),
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: AlamutiTextField(
                          textEditingController: textEditingController,
                        )),
                        TextButton(
                            onPressed: () {
                              signalHelper.sendMessage(
                                receiverId:
                                    chatTargetUserController.userId.value,
                                grouptitle: widget.groupTitle,
                                senderId: storage.read(
                                  CacheManagerKey.USERID.toString(),
                                ),
                                message: textEditingController.text,
                                groupname: null,
                                groupImage: widget.groupImage,
                              );

                              chatMessageController.addMessage(ChatMessage(
                                  id: 44,
                                  sender: storage.read(
                                    CacheManagerKey.USERID.toString(),
                                  ),
                                  message: textEditingController.text,
                                  reciever:
                                      chatTargetUserController.userId.value,
                                  daySended: ''));

                              WidgetsBinding.instance
                                  ?.addPostFrameCallback((_) {
                                if (_scrollcontroller.hasClients) {
                                  _scrollcontroller.jumpTo(_scrollcontroller
                                      .position.maxScrollExtent);
                                }
                              });
                            },
                            child: Text(
                              'ارسال',
                              style: TextStyle(color: Colors.greenAccent),
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );

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
