import 'package:alamuti/add_ads_category_page.dart';
import 'package:alamuti/category_page.dart';
import 'package:alamuti/home_page.dart';
import 'package:alamuti/myalamuti.dart';
import 'package:alamuti/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'chat.dart';
import 'package:get/get_navigation/get_navigation.dart' as trans;

void main() {
  runApp(Application());
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(
            name: '/',
            page: () => HomePage(),
            transition: trans.Transition.noTransition),
        GetPage(
            name: '/category',
            page: () => AlamutCategoryPage(),
            transition: trans.Transition.noTransition),
        GetPage(
          name: '/add_ads',
          page: () => AddAdsCategoryPage(),
          transition: trans.Transition.noTransition,
        ),
        GetPage(
          name: "/chat",
          page: () => Chat(),
          transition: trans.Transition.noTransition,
        ),
        GetPage(
          name: "/myalamuti",
          page: () => MyAlamuti(),
          transition: trans.Transition.noTransition,
        ),
      ],
      theme: themes,
    );
  }
}
