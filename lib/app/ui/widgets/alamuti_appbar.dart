import 'package:alamuti/app/ui/post_ads_category/submit_ads_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlamutiAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBar appBar;
  final bool hasBackButton;

  final Widget backwidget;
  const AlamutiAppBar(
      {Key? key,
      required this.title,
      required this.appBar,
      required this.backwidget,
      required this.hasBackButton})
      : super(key: key);

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
        backgroundColor: Color.fromRGBO(8, 212, 76, 0.5),
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: hasBackButton
            ? GestureDetector(
                onTap: () => Get.to(this.backwidget,
                    transition: Transition.noTransition),
                child: Icon(
                  CupertinoIcons.chevron_back,
                  size: 30,
                ),
              )
            : null,
      );

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
