import 'package:alamuti/app/controller/advertisement_pagination_controller.dart';
import 'package:alamuti/app/controller/chat_message_controller.dart';
import 'package:alamuti/app/data/provider/chat_message_provider.dart';
import 'package:alamuti/app/data/provider/signalr_helper.dart';
import 'package:alamuti/app/data/storage/cache_manager.dart';
import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:alamuti/app/ui/widgets/alamuti_textfield.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:signalr_core/signalr_core.dart';

class Chat extends StatefulWidget with CacheManager {
  final String groupname;

  final String groupTitle;

  final String? groupImage;

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
  final ChatMessageController chatMessageController =
      Get.put(ChatMessageController());

  final AdvertisementPaginationController advertisementPaginationController =
      Get.put(AdvertisementPaginationController());

  final TextEditingController textEditingController = TextEditingController();

  final SignalRHelper signalHelper = SignalRHelper();

  final ScrollController _scrollcontroller = ScrollController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  final ScrollController _scrollControl = ScrollController();

  final MessageProvider messageProvider = MessageProvider();

  final GetStorage storage = GetStorage();

  final double width = Get.width;

  final double height = Get.height;

  @override
  void initState() {
    _scrollControl.addListener(paginationScrollListener);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isAlamutiMessage = widget.groupTitle == 'الموتی';
    advertisementPaginationController.currentPage.value = 1;
    messageProvider.getGroupMessages(widget.groupname);
    chatMessageController.messageList.listen((p0) {
      WidgetsBinding.instance?.addPostFrameCallback((_) async {
        // if (_scrollcontroller.hasClients) {
        //   _scrollcontroller.jumpTo(_scrollcontroller.position.maxScrollExtent);
        // }
        if (signalHelper.getConnectionStatus() ==
            HubConnectionState.disconnected) {
          await signalHelper.initiateConnection();
        }

        await signalHelper.createGroup(
          widget.groupname,
        );
        await signalHelper.reciveMessage();
      });
    });

    return Scaffold(
      appBar: AlamutiAppBar(
        appBar: AppBar(),
        title: 'پیامها',
        hasBackButton: true,
        backwidget: "/chat",
      ),
      body: WillPopScope(
        onWillPop: () async {
          await messageProvider.getGroups();
          Get.offAllNamed('/chat');
          return false;
        },
        child: Container(
          width: width,
          child: Column(
            children: [
              Expanded(
                child: Obx(() => ListView.builder(
                      controller: _scrollControl,
                      itemCount: chatMessageController.messageList.length,
                      itemBuilder: (context, index) {
                        if (chatMessageController.messageList[index].sender ==
                            storage.read(CacheManagerKey.USERID.toString())) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Bubble(
                              style: styleMe,
                              child: Text(chatMessageController
                                  .messageList[index].message),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Bubble(
                              style: styleSomebody,
                              child: Text(chatMessageController
                                  .messageList[index].message),
                            ),
                          );
                        }
                      },
                    )),
              ),
              isAlamutiMessage
                  ? Container()
                  : Form(
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
                                isNumber: false,
                                isPrice: false,
                                isChatTextField: true,
                                hasCharacterLimitation: false,
                                prefix: '',
                              )),
                              TextButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      var target = widget.groupname
                                          .replaceAll(
                                              storage.read(
                                                CacheManagerKey.USERID
                                                    .toString(),
                                              ),
                                              '')
                                          .trimRight();

                                      signalHelper.sendMessage(
                                          receiverId: target,
                                          senderId: storage.read(
                                            CacheManagerKey.USERID.toString(),
                                          ),
                                          message: textEditingController.text,
                                          groupname: widget.groupname,
                                          groupImage: widget.groupImage,
                                          grouptitle: widget.groupTitle);

                                      WidgetsBinding.instance
                                          ?.addPostFrameCallback((_) {
                                        if (_scrollcontroller.hasClients) {
                                          _scrollcontroller.jumpTo(
                                              _scrollcontroller
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

  void paginationScrollListener() {
    if (_scrollControl.offset >= _scrollControl.position.maxScrollExtent) {
      if (advertisementPaginationController.hasNext.value == true) {
        advertisementPaginationController.currentPage.value =
            advertisementPaginationController.currentPage.value + 1;
        messageProvider.getGroupMessages(widget.groupname);
        print('chat scrollll!');
      }
    }
  }

  static const styleSomebody = BubbleStyle(
    nip: BubbleNip.leftCenter,
    color: Colors.white,
    borderColor: Colors.transparent,
    borderWidth: 1,
    elevation: 4,
    margin: BubbleEdges.only(top: 8, right: 50),
    alignment: Alignment.topLeft,
  );

  static const styleMe = BubbleStyle(
    nip: BubbleNip.rightCenter,
    color: Color.fromARGB(255, 225, 255, 199),
    borderColor: Colors.transparent,
    borderWidth: 1,
    elevation: 4,
    margin: BubbleEdges.only(top: 8, left: 50),
    alignment: Alignment.topRight,
  );
}
