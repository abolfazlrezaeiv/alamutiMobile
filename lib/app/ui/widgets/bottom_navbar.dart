import 'package:alamuti/app/controller/search_avoid_update.dart';
import 'package:alamuti/app/controller/selectedTapController.dart';
import 'package:alamuti/app/ui/widgets/buttom_navbar_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlamutBottomNavBar extends StatelessWidget {
  const AlamutBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var selectedTapController = Get.put(ScreenController());

    var checkIsSearchController = Get.put(CheckIsSearchedController());

    return Obx(() => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedTapController.selectedIndex.value,
          onTap: (value) {
            selectedTapController.selectedIndex.value = value;
            checkIsSearchController.isSearchResult.value = false;
            Get.toNamed(
                bottomNavBarScreens[selectedTapController.selectedIndex.value]);
          },
          items: bottomTapItems,
        ));
  }
}
