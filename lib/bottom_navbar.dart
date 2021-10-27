import 'package:alamuti/statics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlamutBottomNavBar extends StatefulWidget {
  const AlamutBottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  State<AlamutBottomNavBar> createState() => _AlamutBottomNavBarState();
}

class _AlamutBottomNavBarState extends State<AlamutBottomNavBar> {
  int selectedTap = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.red,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedTap,
      onTap: (value) {
        setState(() {
          selectedTap = value;
        });
        Get.to(() => bottomNavBarScreens[value]!);
      },
      unselectedLabelStyle: TextStyle(fontSize: 14),
      items: bottomTapItems,
    );
  }
}
