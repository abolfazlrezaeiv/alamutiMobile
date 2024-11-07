import 'package:alamuti/app/controller/chat_info_controller.dart';
import 'package:alamuti/app/controller/selected_tap_controller.dart';
import 'package:alamuti/app/ui/theme.dart';
import 'package:alamuti/app/ui/widgets/bottom_navbar_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlamutiAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBar appBar;
  final bool hasBackButton;
  final String? backwidget;
  final VoidCallback? method;

  AlamutiAppBar({
    Key? key,
    required this.title,
    required this.appBar,
    this.backwidget,
    required this.hasBackButton,
    this.method,
  }) : super(key: key);

  final ScreenController screenController = Get.put(ScreenController());

  @override
  Widget build(BuildContext context) => AppBar(
        leadingWidth: 100,
        actions: [
          backwidget == '/chat' &&
                  Get.put(ChatInfoController()).chat[0].title != 'الموتی'
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () {
                        method!();
                        print('working');
                      },
                      child: Icon(
                        CupertinoIcons.ellipsis_vertical,
                        size: 25,
                      )),
                )
              : Container()
        ],
        title: Text(
          title,
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: Colors.white.withOpacity(0.9)),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: hasBackButton
            ? GestureDetector(
                onTap: () {
                  if (backwidget != null) {
                    if (backwidget == '/chat') {
                      screenController.selectedIndex.value == 3
                          ? Get.back()
                          : Get.toNamed('/home');
                      screenController.selectedIndex.value = 3;
                      newMessageController.haveNewMessage.value = false;
                    }
                  } else {
                    Get.back();
                  }
                },
                child: Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 10),
                  color: alamutPrimaryColor.withOpacity(0.0),
                  child: Icon(
                    CupertinoIcons.back,
                    size: 27,
                  ),
                ),
              )
            : null,
      );

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
