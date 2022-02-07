import 'package:alamuti/app/binding/advertisement_form_binding.dart';
import 'package:alamuti/app/binding/category_submit_ads_binding.dart';
import 'package:alamuti/app/binding/chat_group_binding.dart';
import 'package:alamuti/app/binding/detail_binding.dart';
import 'package:alamuti/app/binding/home_binding.dart';
import 'package:alamuti/app/binding/login_binding.dart';
import 'package:alamuti/app/binding/register_binding.dart';
import 'package:alamuti/app/binding/splash_screen_binding.dart';
import 'package:alamuti/app/binding/user_advertisement_binding.dart';
import 'package:alamuti/app/ui/Login/login.dart';
import 'package:alamuti/app/ui/Login/register.dart';
import 'package:alamuti/app/ui/advetisement_form_page/advertisement_form_page.dart';
import 'package:alamuti/app/ui/chat/chatgroup.dart';
import 'package:alamuti/app/ui/details/detail_page.dart';
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
    transition: trans.Transition.noTransition,
    binding: SplashScreenBinding(),
  ),
  GetPage(
    name: '/home',
    page: () => HomePage(),
    binding: HomeBinding(),
    transition: trans.Transition.noTransition,
  ),
  GetPage(
    name: "/detail",
    page: () => Detail(),
    binding: DetailPageBinding(),
    transition: trans.Transition.fadeIn,
  ),
  GetPage(
    name: '/add_ads',
    page: () => CategorySubmitAds(),
    transition: trans.Transition.noTransition,
    binding: CategorySubmitAdsBinding(),
  ),
  GetPage(
    name: "/chat",
    page: () => ChatGroups(),
    binding: ChatGroupBinding(),
    transition: trans.Transition.noTransition,
  ),
  GetPage(
    name: "/myads",
    page: () => UserAdvertisement(),
    binding: UserAdvertisementBinding(),
    transition: trans.Transition.noTransition,
  ),
  GetPage(
    name: "/ads_form",
    page: () => AdvertisementForm(),
    binding: FormAdvertisementBinding(),
    transition: trans.Transition.noTransition,
  ),
  GetPage(
    name: "/myalamuti",
    page: () => MyAlamutiPage(),
    transition: trans.Transition.noTransition,
  ),
  GetPage(
    name: "/about",
    page: () => AboutAlamuti(),
    transition: trans.Transition.noTransition,
  ),
  GetPage(
    name: "/contact",
    page: () => ContactPage(),
    transition: trans.Transition.noTransition,
  ),
  GetPage(
    name: "/register",
    page: () => Registeration(),
    transition: trans.Transition.noTransition,
    binding: RegisterPageBinding(),
  ),
  GetPage(
      name: "/login",
      page: () => Login(),
      transition: trans.Transition.noTransition,
      binding: LoginPageBinding()),
];
