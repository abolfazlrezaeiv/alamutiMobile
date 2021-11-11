import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/get_navigation.dart' as trans;
import 'submit_ads_category.dart';
import 'category_page.dart';
import 'chat.dart';
import 'home_page.dart';
import 'myalamuti.dart';

var routes = [
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
    page: () => MyAlamuti(),
    transition: trans.Transition.noTransition,
  ),
];
