import 'package:alamuti/app/controller/new_message_controller.dart';
import 'package:alamuti/app/controller/selectedTapController.dart';
import 'package:alamuti/app/ui/statics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlamutBottomNavBar extends StatelessWidget {
  const AlamutBottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenController c = Get.put(ScreenController());

    return Obx(() => BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          currentIndex: c.selectedIndex.value,
          onTap: (value) {
            c.selectedIndex.value = value;
            Get.toNamed(bottomNavBarScreens[c.selectedIndex.value]);
          },
          unselectedLabelStyle: TextStyle(fontSize: 13),
          items: bottomTapItems,
        ));
  }
}
