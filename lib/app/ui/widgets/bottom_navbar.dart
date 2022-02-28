import 'package:alamuti/app/controller/selected_tap_controller.dart';
import 'package:alamuti/app/data/provider/chat_message_provider.dart';
import 'package:alamuti/app/data/provider/signalr_helper.dart';
import 'package:alamuti/app/data/storage/cache_manager.dart';
import 'package:alamuti/app/ui/widgets/bottom_navbar_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlamutBottomNavBar extends StatelessWidget with CacheManager {
  AlamutBottomNavBar({Key? key}) : super(key: key);

  final ScreenController selectedTapController =
      Get.put(ScreenController(), permanent: true);
  final messageProvider = MessageProvider();
  final SignalRHelper signalRHelper = SignalRHelper(
      handler: () => newMessageController.haveNewMessage.value = true);
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

          SignalRHelper signalRHelper = SignalRHelper(handler: () {
            newMessageController.haveNewMessage.value = true;
          });

          signalRHelper.joinToGroups();
        },
        items: bottomTapItems,
      ),
    );
  }
}
