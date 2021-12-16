import 'package:alamuti/app/ui/Login/login.dart';
import 'package:alamuti/app/ui/Login/register.dart';
import 'package:alamuti/app/ui/splash_screen/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/get_navigation.dart' as trans;

import '../ui/chat/chat.dart';
import '../ui/home/home_page.dart';
import '../ui/myalamuti/myalamuti_page.dart';
import '../ui/post_ads_category/submit_ads_category.dart';
import '../ui/category/category_page.dart';

var routes = [
  GetPage(
      name: '/',
      page: () => SplashScreen(),
      transition: trans.Transition.noTransition),
  GetPage(
      name: '/home',
      page: () => HomePage(),
      transition: trans.Transition.noTransition),
  GetPage(
      name: '/category',
      page: () => AlamutCategoryPage(),
      transition: trans.Transition.noTransition),
  GetPage(
    name: '/add_ads',
    page: () => SubmitAdsCategory(),
    transition: trans.Transition.noTransition,
  ),
  GetPage(
    name: "/chat",
    page: () => Chat(),
    transition: trans.Transition.noTransition,
  ),
  GetPage(
    name: "/myalamuti",
    page: () => MyAlamutiPage(),
    transition: trans.Transition.noTransition,
  ),
  GetPage(
    name: "/register",
    page: () => Registeration(),
    transition: trans.Transition.noTransition,
  ),
];
