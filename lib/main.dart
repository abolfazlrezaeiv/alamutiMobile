import 'package:alamuti/add_ads.dart';
import 'package:alamuti/category_page.dart';
import 'package:alamuti/home_page.dart';
import 'package:alamuti/myalamuti.dart';
import 'package:alamuti/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'chat.dart';

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
          transitionDuration: Duration(seconds: 0),
        ),
        GetPage(
            name: '/category',
            page: () => AlamutCategoryPage(),
            transitionDuration: Duration(seconds: 0)),
        GetPage(
          name: '/add_ads',
          page: () => AddAdvertisement(),
          transitionDuration: Duration(seconds: 0),
        ),
        GetPage(
          name: "/chat",
          page: () => Chat(),
          transitionDuration: Duration(seconds: 0),
        ),
        GetPage(
          name: "/myalamuti",
          page: () => MyAlamuti(),
          transitionDuration: Duration(seconds: 0),
        ),
      ],
      theme: themes,
    );
  }
}
