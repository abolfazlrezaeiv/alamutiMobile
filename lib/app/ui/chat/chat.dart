import 'package:alamuti/app/controller/chat_info_controller.dart';
import 'package:alamuti/app/controller/selected_tap_controller.dart';
import 'package:alamuti/app/data/entities/chat_message.dart';
import 'package:alamuti/app/data/provider/chat_message_provider.dart';
import 'package:alamuti/app/data/provider/signalr_helper.dart';
import 'package:alamuti/app/data/storage/cache_manager.dart';
import 'package:alamuti/app/ui/theme.dart';
import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:alamuti/app/ui/widgets/alamuti_textfield.dart';
import 'package:alamuti/app/ui/widgets/buttom_navbar_items.dart';
import 'package:alamuti/app/ui/widgets/exception_indicators/empty_chat_indicator.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class Chat extends StatefulWidget {
  final SignalRHelper? signalRHelper;
  Chat({
    Key? key,
    this.signalRHelper,
  }) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController messageTextEditingController =
      TextEditingController();

  final ScreenController screenController = Get.find();

  final ChatInfoController chatInfoController = Get.find();

  final GlobalKey<FormState> _formKey = GlobalKey();

  final MessageProvider messageProvider = MessageProvider();

  final GetStorage storage = GetStorage();

  final _chatScreenPagingController =
      PagingController<int, ChatMessage>(firstPageKey: 1);

  late SignalRHelper signalRHelper;

  @override
  void initState() {
    _chatScreenPagingController.addPageRequestListener((pageKey) {
      _fetchMessage(pageKey);
    });

    widget.signalRHelper?.handler = () {
      _chatScreenPagingController.refresh();
    };

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isAlamutiMessage = chatInfoController.chat[0].title == 'الموتی';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AlamutiAppBar(
        appBar: AppBar(),
        title: 'پیامها',
        hasBackButton: true,
        backwidget: "/chat",
      ),
      body: WillPopScope(
        onWillPop: () async {
          screenController.selectedIndex.value == 3
              ? Get.back()
              : Get.toNamed('/home');
          screenController.selectedIndex.value = 3;
          newMessageController.haveNewMessage.value = false;
          return true;
        },
        child: Column(
          children: [
            Expanded(
              child: PagedListView.separated(
                pagingController: _chatScreenPagingController,
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
                        padding:
                            EdgeInsets.symmetric(vertical: Get.height / 70),
                        child: Bubble(
                          style: styleMe,
                          child: Text(
                            message.message,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Get.height / 70),
                        child: Bubble(
                          style: styleSomebody,
                          child: Text(
                            message.message,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      );
                    }
                  },
                  noItemsFoundIndicatorBuilder: (context) => EmptyChatIndicator(
                    onTryAgain: () {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: BottomAppBar(
          elevation: 10,
          child: isAlamutiMessage
              ? Container(
                  width: 0,
                  height: 0,
                )
              : Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: AlamutiTextField(
                          textEditingController: messageTextEditingController,
                          isNumber: false,
                          isPrice: false,
                          isChatTextField: true,
                          hasCharacterLimitation: false,
                          prefix: '',
                        )),
                        TextButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await widget.signalRHelper?.sendMessage(
                                    receiverId: chatInfoController
                                        .chat[0].lastMessage.reciever,
                                    senderId: storage.read(
                                      CacheManagerKey.USERID.toString(),
                                    ),
                                    message: messageTextEditingController.text,
                                    groupname: chatInfoController.chat[0].name,
                                    groupImage:
                                        chatInfoController.chat[0].groupImage,
                                    grouptitle:
                                        chatInfoController.chat[0].title);

                                messageTextEditingController.text = '';
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
        ),
      ),
    );
  }

  Future<void> _fetchMessage(int pageKey) async {
    try {
      var newPage = await messageProvider.getGroupMessages(
        number: pageKey,
        size: 11,
        groupname: chatInfoController.chat[0].name,
      );

      final previouslyFetchedItemsCount =
          _chatScreenPagingController.itemList?.length ?? 0;

      final isLastPage = newPage.isLastPage(previouslyFetchedItemsCount);
      final newItems = newPage.itemList;

      if (isLastPage) {
        _chatScreenPagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _chatScreenPagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _chatScreenPagingController.error = error;
    }
  }

  @override
  void dispose() {
    messageTextEditingController.dispose();
    _chatScreenPagingController.dispose();
    super.dispose();
  }
}
