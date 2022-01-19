import 'package:alamuti/app/controller/selected_tap_controller.dart';
import 'package:alamuti/app/ui/theme.dart';
import 'package:alamuti/app/ui/widgets/buttom_navbar_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlamutiAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBar appBar;
  final bool hasBackButton;
  final String? backwidget;

  AlamutiAppBar(
      {Key? key,
      required this.title,
      required this.appBar,
      this.backwidget,
      required this.hasBackButton})
      : super(key: key);

  final ScreenController screenController = Get.put(ScreenController());

  @override
  Widget build(BuildContext context) => AppBar(
        leadingWidth: 100,
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
                  var indexOfBottomNavbar =
                      bottomNavBarScreens.indexOf(backwidget!);

                  screenController.selectedIndex.value = indexOfBottomNavbar;

                  Get.offAllNamed(backwidget!);
                },
                child: Container(
                  width: 100,
                  height: 100,
                  color: alamutPrimaryColor.withOpacity(0.0),
                  child: Icon(
                    CupertinoIcons.chevron_back,
                    size: 30,
                  ),
                ),
              )
            : null,
      );

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
