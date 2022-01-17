import 'package:alamuti/app/controller/search_avoid_update.dart';
import 'package:alamuti/app/controller/selected_tap_controller.dart';
import 'package:alamuti/app/ui/widgets/buttom_navbar_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlamutBottomNavBar extends StatelessWidget {
  AlamutBottomNavBar({Key? key}) : super(key: key);

  final ScreenController selectedTapController = Get.put(ScreenController());

  final CheckIsSearchedController checkIsSearchController =
      Get.put(CheckIsSearchedController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedTapController.selectedIndex.value,
        onTap: (value) {
          selectedTapController.selectedIndex.value = value;
          // checkIsSearchController.isSearchResult.value = false;
          Get.toNamed(
              bottomNavBarScreens[selectedTapController.selectedIndex.value]);
        },
        items: bottomTapItems,
      ),
    );
  }
}
