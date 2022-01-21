import 'package:alamuti/app/controller/message_notifier_controller.dart';
import 'package:alamuti/app/data/entities/chat_message.dart';
import 'package:alamuti/app/data/provider/chat_message_provider.dart';
import 'package:alamuti/app/data/provider/signalr_helper.dart';
import 'package:alamuti/app/data/storage/cache_manager.dart';
import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:alamuti/app/ui/widgets/alamuti_textfield.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class Chat extends StatefulWidget {
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
  final TextEditingController textEditingController = TextEditingController();

  final SignalRHelper signalHelper = SignalRHelper();

  final GlobalKey<FormState> _formKey = GlobalKey();

  final ScrollController _scrollControl = ScrollController();

  final MessageProvider messageProvider = MessageProvider();

  final GetStorage storage = GetStorage();

  final double width = Get.width;

  final double height = Get.height;

  final chatScreenPagingController =
      PagingController<int, ChatMessage>(firstPageKey: 1);

  MessageNotifierController messageNotifierController =
      Get.put(MessageNotifierController());

  @override
  void initState() {
    chatScreenPagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    signalHelper.createGroup(widget.groupname);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isAlamutiMessage = widget.groupTitle == 'الموتی';
    messageNotifierController.connection.listen((val) {
      chatScreenPagingController.refresh();

      print('recived');
    });
    return Scaffold(
      appBar: AlamutiAppBar(
        appBar: AppBar(),
        title: 'پیامها',
        hasBackButton: true,
        backwidget: "/chat",
      ),
      body: Column(
        children: [
          Expanded(
            child: PagedListView.separated(
              pagingController: chatScreenPagingController,
              separatorBuilder: (context, index) => const SizedBox(
                height: 0,
              ),
              shrinkWrap: true,
              reverse: true,
              builderDelegate: PagedChildBuilderDelegate<ChatMessage>(
                  itemBuilder: (context, message, index) {
                if (message.sender ==
                    storage.read(CacheManagerKey.USERID.toString())) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: Get.height / 70),
                    child: Bubble(
                      style: styleMe,
                      child: Text(message.message),
                    ),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: Get.height / 70),
                    child: Bubble(
                      style: styleSomebody,
                      child: Text(message.message),
                    ),
                  );
                }
              }),
            ),
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
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  var target = widget.groupname
                                      .replaceAll(
                                          storage.read(
                                            CacheManagerKey.USERID.toString(),
                                          ),
                                          '')
                                      .trimRight();

                                  await signalHelper.sendMessage(
                                      receiverId: target,
                                      senderId: storage.read(
                                        CacheManagerKey.USERID.toString(),
                                      ),
                                      message: textEditingController.text,
                                      groupname: widget.groupname,
                                      groupImage: widget.groupImage,
                                      grouptitle: widget.groupTitle);

                                  textEditingController.text = '';
                                  // chatScreenPagingController.refresh();
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
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      var newPage = await messageProvider.getGroupMessages(
        number: pageKey,
        size: 11,
        groupname: widget.groupname,
      );

      final previouslyFetchedItemsCount =
          chatScreenPagingController.itemList?.length ?? 0;

      final isLastPage = newPage.isLastPage(previouslyFetchedItemsCount);
      final newItems = newPage.itemList;

      if (isLastPage) {
        chatScreenPagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        chatScreenPagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      chatScreenPagingController.error = error;
    }
  }

  @override
  void dispose() {
    chatScreenPagingController.dispose();
    super.dispose();
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
