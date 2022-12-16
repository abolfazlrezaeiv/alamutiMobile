import 'package:alamuti/app/binding/advertisement_form_binding.dart';
import 'package:alamuti/app/binding/category_submit_ads_binding.dart';
import 'package:alamuti/app/binding/chat_group_binding.dart';
import 'package:alamuti/app/binding/detail_binding.dart';
import 'package:alamuti/app/binding/home_binding.dart';
import 'package:alamuti/app/binding/login_binding.dart';
import 'package:alamuti/app/binding/register_binding.dart';
import 'package:alamuti/app/binding/splash_screen_binding.dart';
import 'package:alamuti/app/ui/Login/login.dart';
import 'package:alamuti/app/ui/Login/register.dart';
import 'package:alamuti/app/ui/advertisement_form_page/advertisement_form_page.dart';
import 'package:alamuti/app/ui/chat/chatgroup.dart';
import 'package:alamuti/app/ui/details/detail_page.dart';
import 'package:alamuti/app/ui/home/home_page.dart';
import 'package:alamuti/app/ui/my_alamuti/about_alamuti.dart';
import 'package:alamuti/app/ui/my_alamuti/contactus.dart';
import 'package:alamuti/app/ui/my_alamuti/my_alamuti_page.dart';
import 'package:alamuti/app/ui/my_alamuti/user_advertisement.dart';
import 'package:alamuti/app/ui/post_ads_category/category_submit_advertisement.dart';
import 'package:alamuti/app/ui/splash_screen/splash_screen.dart';
import 'package:get/get_navigation/get_navigation.dart' as trans;
import 'package:get/get_navigation/src/routes/get_route.dart';

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
    name: '/add-ads',
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
    name: "/user-ads",
    page: () => UserAdvertisement(),
    transition: trans.Transition.noTransition,
  ),
  GetPage(
    name: "/ads-form",
    page: () => AdvertisementForm(),
    binding: FormAdvertisementBinding(),
    transition: trans.Transition.noTransition,
  ),
  GetPage(
    name: "/my-alamuti",
    page: () => MyAlamuti(),
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
    name: "/authenticate",
    page: () => AuthenticationScreen(),
    transition: trans.Transition.noTransition,
    binding: RegisterPageBinding(),
  ),
  GetPage(
    name: "/login",
    page: () => OtpVerificationScreen(),
    transition: trans.Transition.noTransition,
    binding: LoginPageBinding(),
  ),
];
