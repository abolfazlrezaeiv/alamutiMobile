import 'package:alamuti/add_ads_category_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlamutiAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBar appBar;
  const AlamutiAppBar({Key? key, required this.title, required this.appBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) => AppBar(
        leadingWidth: 100,
        title: Text(title),
        backgroundColor: Color.fromRGBO(8, 212, 76, 0.5),
        leading: Container(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () => Get.to(AddAdsCategoryPage()),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.chevron_back,
                  size: 20,
                ),
                Text(
                  'بازگشت',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      );

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}