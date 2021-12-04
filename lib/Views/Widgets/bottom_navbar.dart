import 'package:alamuti/selectedTapController.dart';
import 'package:alamuti/statics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlamutBottomNavBar extends StatelessWidget {
  const AlamutBottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenController c = Get.put(ScreenController());
    return GetBuilder<ScreenController>(
      builder: (controller) {
        return BottomNavigationBar(
          selectedItemColor: Colors.red,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          currentIndex: c.getScreen(),
          onTap: (value) {
            c.selectIndex(value);
            Get.toNamed(bottomNavBarScreens[c.getScreen()]);
          },
          unselectedLabelStyle: TextStyle(fontSize: 14),
          items: bottomTapItems,
        );
      },
    );
  }
}
