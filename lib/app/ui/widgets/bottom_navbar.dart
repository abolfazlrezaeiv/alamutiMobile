import 'package:alamuti/app/controller/selected_tap_controller.dart';
import 'package:alamuti/app/data/provider/chat_message_provider.dart';
import 'package:alamuti/app/data/provider/signalr_helper.dart';
import 'package:alamuti/app/data/storage/cache_manager.dart';
import 'package:alamuti/app/ui/widgets/buttom_navbar_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// ignore: must_be_immutable
class AlamutBottomNavBar extends StatelessWidget {
  AlamutBottomNavBar({Key? key}) : super(key: key);

  final ScreenController selectedTapController =
      Get.put(ScreenController(), permanent: true);
  var messageProvider = MessageProvider();
  var storage = GetStorage();
  SignalRHelper signalRHelper = SignalRHelper(handler: () {
    newMessageController.haveNewMessage.value = true;
  });
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 5),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedTapController.selectedIndex.value,
          onTap: (value) async {
            selectedTapController.selectedIndex.value = value;

            Get.offNamed(
                bottomNavBarScreens[selectedTapController.selectedIndex.value],
                preventDuplicates: true);

            SignalRHelper signalRHelper = SignalRHelper(handler: () {
              newMessageController.haveNewMessage.value = true;
            });

            var chats = await messageProvider.getGroupsNoPagination();

            chats.forEach((chat) async => {
                  await signalRHelper.joinToGroup(chat.name),
                  if (chat.isChecked == false &&
                      chat.lastMessage.sender !=
                          storage.read(
                            CacheManagerKey.USERID.toString(),
                          ))
                    {newMessageController.haveNewMessage.value = true}
                });
          },
          items: bottomTapItems,
        ),
      ),
    );
  }
}
