import 'package:alamuti/app/controller/chat_message_controller.dart';
import 'package:alamuti/app/controller/chat_target_controller.dart';
import 'package:alamuti/app/data/model/chatMessage.dart';
import 'package:alamuti/app/data/provider/signalr_helper.dart';
import 'package:alamuti/app/data/storage/cachemanager.dart';
import 'package:alamuti/app/ui/chat/chatgroup.dart';
import 'package:alamuti/app/ui/theme.dart';
import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:alamuti/app/ui/widgets/alamuti_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_9.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NewChat extends StatelessWidget with CacheManager {
  final String receiverId;
  final String? groupImage;
  final String groupTitle;
  NewChat(
      {Key? key,
      required this.groupTitle,
      required this.receiverId,
      required this.groupImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    late SignalRHelper signalHelper;
    var _scrollcontroller = ScrollController();

    final GlobalKey<FormState> _formKey = GlobalKey();

    var storage = GetStorage();

    signalHelper = SignalRHelper();
    signalHelper.initiateConnection();
    signalHelper.reciveMessage();
    var chatTargetUserController = Get.put(ChatTargetUserController());
    var chatMessageController = Get.put(ChatMessageController());
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
        width: Get.width,
        child: Obx(
          () => Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollcontroller,
                  itemCount: chatMessageController.messageList.length,
                  itemBuilder: (context, index) {
                    var storage = GetStorage();
                    if (chatMessageController.messageList[index].sender ==
                        storage.read(CacheManagerKey.USERID.toString())) {
                      return ChatBubble(
                        clipper:
                            ChatBubbleClipper9(type: BubbleType.sendBubble),
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.only(top: 20),
                        backGroundColor: alamutPrimaryColor,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: Get.width * 0.7,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                chatMessageController
                                    .messageList[index].message,
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
                                        .messageList[index].daySended,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontFamily: persianNumber,
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
                        clipper:
                            ChatBubbleClipper9(type: BubbleType.receiverBubble),
                        backGroundColor: Color(0xffE7E7ED),
                        margin: EdgeInsets.only(top: 20),
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: Get.width * 0.7,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                chatMessageController
                                    .messageList[index].message,
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
                                        .messageList[index].daySended,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontFamily: persianNumber,
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
              Form(
                key: _formKey,
                child: Container(
                  color: Colors.grey.withOpacity(0.1),
                  // height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: AlamutiTextField(
                          textEditingController: textEditingController,
                          hasCharacterLimitation: false,
                          isChatTextField: true,
                          isPrice: false,
                          isNumber: false,
                          prefix: '',
                        )),
                        TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                signalHelper.sendMessage(
                                  receiverId:
                                      chatTargetUserController.userId.value,
                                  grouptitle: groupTitle,
                                  senderId: storage.read(
                                    CacheManagerKey.USERID.toString(),
                                  ),
                                  message: textEditingController.text,
                                  groupname: null,
                                  groupImage: groupImage,
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
                                textEditingController.text = '';
                              }
                            },
                            child: Text(
                              'ارسال',
                              style: TextStyle(color: Colors.greenAccent),
                            ))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
