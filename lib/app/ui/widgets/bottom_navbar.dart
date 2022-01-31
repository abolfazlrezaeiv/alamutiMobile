import 'package:alamuti/app/controller/selected_tap_controller.dart';
import 'package:alamuti/app/data/provider/chat_message_provider.dart';
import 'package:alamuti/app/data/provider/signalr_helper.dart';
import 'package:alamuti/app/data/storage/cache_manager.dart';
import 'package:alamuti/app/ui/widgets/buttom_navbar_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
      () => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedTapController.selectedIndex.value,
        onTap: (value) async {
          selectedTapController.selectedIndex.value = value;

          Get.offNamed(
              bottomNavBarScreens[selectedTapController.selectedIndex.value],
              preventDuplicates: true);

          var chats = await messageProvider.getGroupsNoPagination();

          await signalRHelper
              .joinToGroup(storage.read(CacheManagerKey.USERID.toString()));

          chats.forEach(
              (group) async => await signalRHelper.joinToGroup(group.name));
        },
        items: bottomTapItems,
      ),
    );
  }
}
