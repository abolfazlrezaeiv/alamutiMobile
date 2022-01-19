import 'package:alamuti/app/controller/chat_message_controller.dart';
import 'package:alamuti/app/controller/chat_target_controller.dart';
import 'package:alamuti/app/data/model/chat_message.dart';
import 'package:alamuti/app/data/provider/chat_message_provider.dart';
import 'package:alamuti/app/data/provider/signalr_helper.dart';
import 'package:alamuti/app/data/storage/cache_manager.dart';
import 'package:alamuti/app/ui/theme.dart';
import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:alamuti/app/ui/widgets/alamuti_textfield.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
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

  final double width = Get.width;

  final double height = Get.height;

  final chatTargetUserController = Get.put(ChatTargetUserController());

  final chatMessageController = Get.put(ChatMessageController());

  final MessageProvider messageProvider = MessageProvider();

  final _scrollcontroller = ScrollController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  final SignalRHelper signalHelper = SignalRHelper();

  final GetStorage storage = GetStorage();

  static const styleSomebody = BubbleStyle(
    nip: BubbleNip.leftCenter,
    color: Colors.white,
    borderWidth: 1,
    elevation: 4,
    margin: BubbleEdges.only(top: 8, right: 50),
    alignment: Alignment.topLeft,
  );

  static const styleMe = BubbleStyle(
    nip: BubbleNip.rightCenter,
    color: Color.fromARGB(255, 225, 255, 199),
    borderWidth: 1,
    elevation: 4,
    margin: BubbleEdges.only(top: 8, left: 50),
    alignment: Alignment.topRight,
  );

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    chatMessageController.messageList.listen((p0) {
      WidgetsBinding.instance?.addPostFrameCallback((_) async {
        await signalHelper.initiateConnection();

        signalHelper.reciveMessage();
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
        backwidget: "/chat",
      ),
      body: Container(
        width: width,
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
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Bubble(
                          style: styleMe,
                          child: Text(
                              chatMessageController.messageList[index].message),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Bubble(
                          style: styleSomebody,
                          child: Text(
                              chatMessageController.messageList[index].message),
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
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                chatMessageController.addMessage(ChatMessage(
                                    id: 44,
                                    sender: storage.read(
                                      CacheManagerKey.USERID.toString(),
                                    ),
                                    message: textEditingController.text,
                                    reciever:
                                        chatTargetUserController.userId.value,
                                    daySended: ''));

                                await signalHelper.sendMessage(
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
