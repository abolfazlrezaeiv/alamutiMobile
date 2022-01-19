import 'package:alamuti/app/controller/new_message_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var newMessageController = Get.put(NewMessageController(), permanent: true);
var bottomTapItems = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(CupertinoIcons.person),
    label: "الموتی من",
  ),
  BottomNavigationBarItem(
      icon: Obx(
        () => Stack(
          children: [
            Icon(CupertinoIcons.chat_bubble),
            newMessageController.haveNewMessage.value
                ? Icon(
                    CupertinoIcons.circle_fill,
                    color: Colors.red,
                    size: 13,
                  )
                : Icon(CupertinoIcons.chat_bubble),
          ],
        ),
      ),
      label: "پیامها"),
  BottomNavigationBarItem(icon: Icon(CupertinoIcons.add), label: "ثبت آگهی"),
  BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: "خانه"),
];

var bottomNavBarScreens = ['/myalamuti', '/chat', '/add_ads', '/home'];
