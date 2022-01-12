import 'package:alamuti/app/binding/category_submit_ads_binding.dart';
import 'package:alamuti/app/binding/chat_group_binding.dart';
import 'package:alamuti/app/binding/home_binding.dart';
import 'package:alamuti/app/binding/splash_screen_binding.dart';
import 'package:alamuti/app/binding/user_advertisement_binding.dart';
import 'package:alamuti/app/ui/Login/register.dart';
import 'package:alamuti/app/ui/advetisement_form_page/advertisement_form_page.dart';
import 'package:alamuti/app/ui/chat/chatgroup.dart';
import 'package:alamuti/app/ui/home/home_page.dart';
import 'package:alamuti/app/ui/myalamuti/about_alamuti.dart';
import 'package:alamuti/app/ui/myalamuti/contactus.dart';
import 'package:alamuti/app/ui/myalamuti/user_advertisement.dart';
import 'package:alamuti/app/ui/myalamuti/myalamuti_page.dart';
import 'package:alamuti/app/ui/post_ads_category/category_submit_advertisement.dart';
import 'package:alamuti/app/ui/splash_screen/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/get_navigation.dart' as trans;

var routes = [
  GetPage(
    name: '/',
    page: () => SplashScreen(),
    transition: trans.Transition.fadeIn,
    binding: SplashScreenBinding(),
  ),
  GetPage(
    name: '/home',
    page: () => HomePage(),
    binding: HomeBinding(),
    transition: trans.Transition.fadeIn,
  ),
  GetPage(
    name: '/add_ads',
    page: () => CategorySubmitAds(),
    transition: trans.Transition.fadeIn,
    binding: CategorySubmitAdsBinding(),
  ),
  GetPage(
    name: "/chat",
    page: () => ChatGroups(),
    binding: ChatGroupBinding(),
    transition: trans.Transition.fadeIn,
  ),
  GetPage(
    name: "/myads",
    page: () => UserAdvertisement(),
    binding: UserAdvertisementBinding(),
    transition: trans.Transition.fadeIn,
  ),
  GetPage(
    name: "/ads_form",
    page: () => AdvertisementForm(),
    transition: trans.Transition.fadeIn,
  ),
  GetPage(
    name: "/myalamuti",
    page: () => MyAlamutiPage(),
    transition: trans.Transition.fadeIn,
  ),
  GetPage(
    name: "/about",
    page: () => AboutAlamuti(),
    transition: trans.Transition.fadeIn,
  ),
  GetPage(
    name: "/contact",
    page: () => ContactPage(),
    transition: trans.Transition.fadeIn,
  ),
  GetPage(
    name: "/register",
    page: () => Registeration(),
    transition: trans.Transition.fadeIn,
  ),
];
