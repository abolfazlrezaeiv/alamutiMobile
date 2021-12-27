import 'package:alamuti/app/controller/chat_group_controller.dart';
import 'package:alamuti/app/controller/chat_message_controller.dart';
import 'package:alamuti/app/controller/chat_target_controller.dart';
import 'package:alamuti/app/data/model/chatMessage.dart';
import 'package:alamuti/app/data/provider/chat_message_provider.dart';
import 'package:alamuti/app/data/provider/signalr_helper.dart';
import 'package:alamuti/app/data/storage/cachemanager.dart';
import 'package:alamuti/app/ui/chat/chatgroup.dart';
import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:alamuti/app/ui/widgets/alamuti_textfield.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Chat extends StatefulWidget with CacheManager {
  final String groupname;

  final String groupTitle;

  final String groupImage;

  Chat({
    Key? key,
    required this.groupname,
    required this.groupTitle,
    required this.groupImage,
  }) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController textEditingController = TextEditingController();
  late SignalRHelper signalHelper;
  var _scrollcontroller = ScrollController();

  ChatTargetUserController chatTargetUserController =
      Get.put(ChatTargetUserController());

  ChatMessageController chatMessageController =
      Get.put(ChatMessageController());

  ChatGroupController chatGroupController = Get.put(ChatGroupController());

  MessageProvider mp = MessageProvider();

  var storage = GetStorage();

  bool isResponse = false;

  @override
  void initState() {
    super.initState();
    signalHelper = SignalRHelper();
    signalHelper.initiateConnection();
    signalHelper.reciveMessage();
    signalHelper.createGroup(
      widget.groupname,
    );

    mp.getGroupMessages(widget.groupname);
  }

  @override
  Widget build(BuildContext context) {
    signalHelper = SignalRHelper();
    signalHelper.initiateConnection();
    signalHelper.reciveMessage();
    signalHelper.createGroup(
      widget.groupname,
    );

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
        title: 'پیامها',
        hasBackButton: true,
        backwidget: ChatGroups(),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: Obx(() => ListView.builder(
                    controller: _scrollcontroller,
                    itemCount: chatMessageController.messageList.length,
                    itemBuilder: (context, index) {
                      var storage = GetStorage();
                      if (chatMessageController
                              .messageList.value[index].sender ==
                          storage.read(CacheManagerKey.USERID.toString())) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width / 1.4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Bubble(
                              margin: BubbleEdges.only(top: 10),
                              alignment: Alignment.topRight,
                              nipWidth: 8,
                              nipHeight: 24,
                              nip: BubbleNip.rightTop,
                              color: Color.fromRGBO(225, 255, 199, 1.0),
                              child: Text(
                                chatMessageController
                                    .messageList.value[index].message,
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.only(
                              //       right: 150, left: 8, bottom: 8, top: 8),
                              //   child: Card(
                              //     elevation: 4,
                              //     child: Padding(
                              //       padding: const EdgeInsets.all(15.0),
                              //       child: Text(
                              //         chatMessageController
                              //             .messageList.value[index].message,
                              //         textDirection: TextDirection.rtl,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                child: Bubble(
                                  margin: BubbleEdges.only(top: 10),
                                  alignment: Alignment.topLeft,
                                  nipWidth: 8,
                                  nipHeight: 24,
                                  nip: BubbleNip.leftTop,
                                  color: Colors.white,
                                  child: Text(
                                    chatMessageController
                                        .messageList.value[index].message,
                                    textDirection: TextDirection.rtl,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Bubble(
                                alignment: Alignment.center,
                                color: Color.fromRGBO(212, 234, 244, 1.0),
                                child: Text(
                                    chatMessageController
                                        .messageList.value[index].daySended,
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'IRANSansXFaNum',
                                        fontSize: 11)),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  )),
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
                          var target = widget.groupname
                              .replaceAll(
                                  storage.read(
                                    CacheManagerKey.USERID.toString(),
                                  ),
                                  '')
                              .trimRight();

                          signalHelper.sendMessage(
                              receiverId:
                                  chatTargetUserController.userId.value.length <
                                          2
                                      ? target
                                      : chatTargetUserController.userId.value,
                              senderId: storage.read(
                                CacheManagerKey.USERID.toString(),
                              ),
                              message: textEditingController.text,
                              groupname: widget.groupname,
                              groupImage: widget.groupImage,
                              grouptitle: widget.groupTitle);

                          // chatMessageController.addMessage(ChatMessage(
                          //     id: 44,
                          //     sender: storage.read(
                          //       CacheManagerKey.USERID.toString(),
                          //     ),
                          //     message: textEditingController.text,
                          //     reciever: chatTargetUserController.userId.value));
                          print(textEditingController.text);
                          WidgetsBinding.instance?.addPostFrameCallback((_) {
                            if (_scrollcontroller.hasClients) {
                              _scrollcontroller.jumpTo(
                                  _scrollcontroller.position.maxScrollExtent);
                            }
                          });
                        },
                        child: Text('ارسال'))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
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
