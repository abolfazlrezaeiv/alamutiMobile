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
  final String groupname;
  final String groupTitle;
  final String receiverId;
  final String? groupImage;
  final SignalRHelper? signalRHelper;
  Chat({
    Key? key,
    required this.groupname,
    required this.groupTitle,
    required this.groupImage,
    required this.receiverId,
    this.signalRHelper,
  }) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController messageTextEditingController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  final MessageProvider messageProvider = MessageProvider();

  final GetStorage storage = GetStorage();

  final double width = Get.width;

  final double height = Get.height;

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
    final isAlamutiMessage = widget.groupTitle == 'الموتی';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AlamutiAppBar(
        appBar: AppBar(),
        title: 'پیامها',
        hasBackButton: true,
        backwidget: "/chat",
      ),
      body: WillPopScope(
        onWillPop: () async {
          // widget.signalRHelper?.connection.off('ReceiveMessage');
          Get.put(ScreenController()).selectedIndex.value = 3;
          Get.toNamed('/home');
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
                    // messageProvider.changeToSeen(groupname: widget.groupname);

                    // WidgetsBinding.instance?.addPostFrameCallback((_) async {
                    //   Get.put(NewMessageController()).haveNewMessage.value =
                    //       false;
                    // });

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
      bottomNavigationBar: SafeArea(
        bottom: true,
        maintainBottomViewPadding: true,
        child: BottomAppBar(
          child: isAlamutiMessage
              ? Container()
              : Form(
                  key: _formKey,
                  child: Container(
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
                                      receiverId: widget.receiverId,
                                      senderId: storage.read(
                                        CacheManagerKey.USERID.toString(),
                                      ),
                                      message:
                                          messageTextEditingController.text,
                                      groupname: widget.groupname,
                                      groupImage: widget.groupImage,
                                      grouptitle: widget.groupTitle);

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
      ),
    );
  }

  Future<void> _fetchMessage(int pageKey) async {
    try {
      var newPage = await messageProvider.getGroupMessages(
        number: pageKey,
        size: 11,
        groupname: widget.groupname,
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
