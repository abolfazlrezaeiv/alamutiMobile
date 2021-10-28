import 'package:alamuti/category_page.dart';
import 'package:alamuti/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectedTapController extends GetxController {
  var tapIndex = 0;
  change(int newValue) {
    tapIndex = newValue;
    update();
  }
}

class ScreenController extends GetxController {
  int selectedIndex = 2;
  List<Widget> _screenList = [
    AlamutCategoryPage(),
    HomePage(),
    AlamutCategoryPage(),
    HomePage(),
    AlamutCategoryPage(),
  ];

  selectIndex(int index) {
    selectedIndex = index;
    update();
  }

  getScreen() => selectedIndex;
}

class HomeScreen {}
