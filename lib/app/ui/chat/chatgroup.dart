import 'dart:convert';
import 'package:alamuti/app/controller/new_message_controller.dart';
import 'package:alamuti/app/controller/selected_tap_controller.dart';
import 'package:alamuti/app/data/entities/chatgroup.dart';
import 'package:alamuti/app/data/provider/chat_message_provider.dart';
import 'package:alamuti/app/data/provider/signalr_helper.dart';
import 'package:alamuti/app/data/storage/cache_manager.dart';
import 'package:alamuti/app/ui/chat/chat.dart';
import 'package:alamuti/app/ui/theme.dart';
import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:alamuti/app/ui/widgets/bottom_navbar.dart';
import 'package:alamuti/app/ui/widgets/exception_indicators/empty_chat_group_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ChatGroups extends StatefulWidget {
  ChatGroups({Key? key}) : super(key: key);

  @override
  State<ChatGroups> createState() => _ChatGroupsState();
}

class _ChatGroupsState extends State<ChatGroups> with CacheManager {
  final MessageProvider messageProvider = MessageProvider();

  final GetStorage storage = GetStorage();

  final double width = Get.width;

  final double height = Get.height;

  final NewMessageController newMessageController = Get.find();

  final groupChatScreenPagingController =
      PagingController<int, ChatGroup>(firstPageKey: 1);

  late SignalRHelper signalHelper;

  @override
  void initState() {
    super.initState();
    groupChatScreenPagingController.addPageRequestListener((pageKey) {
      _fetchGroups(pageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    signalHelper =
        SignalRHelper(handler: () => groupChatScreenPagingController.refresh());
    return Scaffold(
      appBar: AlamutiAppBar(
        appBar: AppBar(),
        title: 'پیامها',
        hasBackButton: false,
      ),
      bottomNavigationBar: AlamutBottomNavBar(),
      body: WillPopScope(
        onWillPop: () async {
          Get.put(ScreenController()).selectedIndex.value = 3;
          Get.offAllNamed('/home');
          return false;
        },
        child: PagedListView.separated(
          pagingController: groupChatScreenPagingController,
          separatorBuilder: (context, index) => const SizedBox(
            height: 0,
          ),
          builderDelegate: PagedChildBuilderDelegate<ChatGroup>(
              noItemsFoundIndicatorBuilder: (context) =>
                  EmptyChatGroupIndicator(
                    onTryAgain: () {},
                  ),
              itemBuilder: (context, group, index) {
                signalHelper.joinToGroup(group.name);

                return GestureDetector(
                  onLongPress: () {
                    Get.defaultDialog(
                      radius: 5,
                      title: 'از حذف چت مطمئن هستید ؟ ',
                      barrierDismissible: false,
                      titlePadding: EdgeInsets.all(20),
                      titleStyle: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                      ),
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'پیامهای مربوط به این کاربر حذف میشوند',
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      cancel: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            'انصراف',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: Colors.green),
                          ),
                        ),
                      ),
                      confirm: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextButton(
                            onPressed: () async {
                              await messageProvider.deleteMessageGroup(
                                groupName: group.name,
                              );
                              groupChatScreenPagingController.refresh();
                              Get.back();
                            },
                            child: Text(
                              'حذف',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                  color: Colors.red),
                            )),
                      ),
                    );
                  },
                  onTap: () async {
                    if (await getUserId() != group.lastMessage.sender) {
                      await messageProvider.updateGroupStatus(
                          name: group.name,
                          id: group.id,
                          title: group.title,
                          isChecked: true);
                      newMessageController.haveNewMessage.value = false;
                    }
                    signalHelper.joinToGroup(group.name);

                    Get.to(
                      () => Chat(
                        groupname: group.name,
                        groupTitle: group.title,
                        groupImage: group.groupImage,
                        receiverId: '',
                        signalRHelper: signalHelper,
                        groupId: group.id,
                      ),
                      transition: Transition.fadeIn,
                    );
                  },
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(height / 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                group.lastMessage.message,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontWeight: (group.isChecked == false &&
                                            group.lastMessage.sender !=
                                                storage.read(
                                                  CacheManagerKey.USERID
                                                      .toString(),
                                                ))
                                        ? FontWeight.w500
                                        : FontWeight.w300,
                                    fontSize: 13),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: height / 80,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    group.title,
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: persianNumber,
                                        fontSize: 12),
                                  ),
                                  SizedBox(
                                    width: width / 30,
                                  ),
                                  FittedBox(
                                    fit: BoxFit.fill,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      // ignore: unnecessary_null_comparison
                                      child: (group.groupImage != null &&
                                              group.groupImage.length > 4)
                                          ? Image.memory(
                                              base64Decode(group.groupImage),
                                              filterQuality: FilterQuality.low,
                                              fit: BoxFit.cover,
                                              width: width / 7,
                                              height: width / 7,
                                            )
                                          : ((group.title == 'الموتی'
                                              ? Image.asset(
                                                  'assets/logo/logo.png',
                                                  fit: BoxFit.fitWidth,
                                                  width: width / 7,
                                                  height: width / 7,
                                                )
                                              : Image.asset(
                                                  'assets/logo/no-image.png',
                                                  fit: BoxFit.cover,
                                                  width: width / 7,
                                                  height: width / 7,
                                                ))),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            group.lastMessage.daySended,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                fontWeight: FontWeight.w200,
                                fontFamily: persianNumber,
                                fontSize: 12),
                          ),
                        ),
                      ),
                      (group.isChecked == false &&
                              group.lastMessage.sender !=
                                  storage.read(
                                    CacheManagerKey.USERID.toString(),
                                  ))
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 40),
                              child: Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.25),
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(2),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red),
                                    child: Container(),
                                  ),
                                ),
                              ),
                            )
                          : Container(color: Colors.transparent)
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  Future<void> _fetchGroups(int pageKey) async {
    try {
      var newPage = await messageProvider.getGroups(
        number: pageKey,
        size: 11,
      );

      final previouslyFetchedItemsCount =
          groupChatScreenPagingController.itemList?.length ?? 0;

      final isLastPage = newPage.isLastPage(previouslyFetchedItemsCount);
      final newItems = newPage.itemList;

      if (isLastPage) {
        groupChatScreenPagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        groupChatScreenPagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      groupChatScreenPagingController.error = error;
    }
  }

  @override
  void dispose() {
    groupChatScreenPagingController.dispose();

    super.dispose();
  }
}
