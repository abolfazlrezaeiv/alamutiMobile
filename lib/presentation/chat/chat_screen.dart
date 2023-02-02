import 'package:alamuti/data/datasources/apicalls/chat_message_apicall.dart';
import 'package:alamuti/data/datasources/apicalls/signalr_helper.dart';
import 'package:alamuti/data/datasources/storage/cache_manager.dart';
import 'package:alamuti/data/entities/chat_message.dart';
import 'package:alamuti/domain/controllers/chat_info_controller.dart';
import 'package:alamuti/domain/controllers/selected_tap_controller.dart';
import 'package:alamuti/presentation/dialoges/alert_dialog_class.dart';
import 'package:alamuti/presentation/themes/theme.dart';
import 'package:alamuti/presentation/widgets/alamuti_appbar.dart';
import 'package:alamuti/presentation/widgets/alamuti_textfield.dart';
import 'package:alamuti/presentation/widgets/buttom_navbar_items.dart';
import 'package:alamuti/presentation/widgets/exception_indicators/empty_chat_indicator.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pushe_flutter/pushe.dart';

class ChatScreen extends StatefulWidget {
  final SignalRHelper? signalRHelper;
  ChatScreen({
    Key? key,
    this.signalRHelper,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageTextEditingController =
      TextEditingController();

  final TextEditingController reportTextEditingCtrl = TextEditingController();

  final ScreenController screenController = Get.find();

  final ChatInfoController chatInfoController = Get.find();

  final GlobalKey<FormState> _formKey = GlobalKey();

  final MessageProvider messageProvider = MessageProvider();

  final GetStorage storage = GetStorage();

  final _chatScreenPagingController =
      PagingController<int, ChatMessage>(firstPageKey: 1);

  late SignalRHelper signalRHelper;

  var receiverId;

  @override
  void initState() {
    _chatScreenPagingController.addPageRequestListener((pageKey) {
      _fetchMessage(pageKey);
    });

    widget.signalRHelper?.handler = () {
      _chatScreenPagingController.refresh();
    };

    if (chatInfoController.chat[0].name.toString().split('_')[0] ==
        storage.read(CacheManagerKey.USERID.toString())) {
      receiverId = chatInfoController.chat[0].name.toString().split('_')[1];
    } else {
      receiverId = chatInfoController.chat[0].name.toString().split('_')[0];
    }

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
        method: isAlamutiMessage ? null : showMenu,
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
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
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
                    noItemsFoundIndicatorBuilder: (context) =>
                        EmptyChatIndicator(
                      onTryAgain: () {},
                    ),
                  ),
                ),
              ),
            ],
          ),
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
                          child: PhysicalModel(
                            borderRadius: BorderRadius.circular(9),
                            color: Colors.white,
                            elevation: 2.0,
                            shadowColor: Colors.black,
                            child: AlamutiTextField(
                              textEditingController:
                                  messageTextEditingController,
                              isNumber: false,
                              isPrice: false,
                              isChatTextField: true,
                              hasCharacterLimitation: false,
                              prefix: '',
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                sendMessage();
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

  showMenu() async {
    await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
        ),
        context: context,
        builder: (context) {
          return BottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
            ),
            enableDrag: false,
            onClosing: () {},
            builder: (BuildContext context) {
              return FractionallySizedBox(
                heightFactor: 0.4,
                child: Column(
                  children: [
                    SizedBox(
                      width: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(height: 2, thickness: 5),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12),
                      child: GestureDetector(
                        onTap: () async {
                          Alert.chatDeleteDialog(
                              groupName: chatInfoController.chat[0].name,
                              context: context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'حذف و اتمام مکالمه',
                              style: TextStyle(fontSize: Get.width / 27),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.delete,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12),
                      child: GestureDetector(
                        onTap: () async {
                          Alert.showChatReportDialog(
                              context,
                              reportTextEditingCtrl,
                              chatInfoController.chat[0].name,
                              receiverId);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'گزارش و مسدود کردن',
                              style: TextStyle(fontSize: Get.width / 27),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              CupertinoIcons.exclamationmark_circle_fill,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  Future<void> sendMessage() async {
    await widget.signalRHelper?.sendMessage(
        receiverId: receiverId,
        senderId: storage.read(
          CacheManagerKey.USERID.toString(),
        ),
        message: messageTextEditingController.text,
        groupname: chatInfoController.chat[0].name,
        groupImage: chatInfoController.chat[0].groupImage,
        grouptitle: chatInfoController.chat[0].title);

    _chatScreenPagingController.refresh();

    await Pushe.sendNotificationToUser(
        IdType.CustomId,
        receiverId, // Or another Id
        'چت الموتی',
        messageTextEditingController.text, // content
        bigTitle: 'چت الموتی',
        bigContent: messageTextEditingController.text,
        imageUrl: null,
        iconUrl: null,
        customContent: {'key1': 'value1'});

    messageTextEditingController.text = '';
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
    reportTextEditingCtrl.dispose();
    _chatScreenPagingController.dispose();
    super.dispose();
  }
}
