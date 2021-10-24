import 'package:alamuti/category_page.dart';
import 'package:alamuti/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const bottomTapItems = const <BottomNavigationBarItem>[
  BottomNavigationBarItem(
      icon: Icon(
        CupertinoIcons.person,
      ),
      label: "الموتی من"),
  BottomNavigationBarItem(
      icon: Icon(
        CupertinoIcons.chat_bubble,
      ),
      label: "پیامها"),
  BottomNavigationBarItem(
      icon: Icon(
        CupertinoIcons.add,
      ),
      label: "ثبت آگهی"),
  BottomNavigationBarItem(
      icon: Icon(
        CupertinoIcons.square_grid_2x2,
      ),
      label: "دسته بندی"),
  BottomNavigationBarItem(
      icon: Icon(
        CupertinoIcons.home,
      ),
      label: "خانه"),
];

var bottomNavBarScreens = [null, null, null, AlamutCategoryPage(), HomePage()];
