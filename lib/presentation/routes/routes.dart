import 'package:alamuti/domain/binding/advertisement_form_binding.dart';
import 'package:alamuti/domain/binding/category_submit_ads_binding.dart';
import 'package:alamuti/domain/binding/chat_group_binding.dart';
import 'package:alamuti/domain/binding/detail_binding.dart';
import 'package:alamuti/domain/binding/home_binding.dart';
import 'package:alamuti/domain/binding/login_binding.dart';
import 'package:alamuti/domain/binding/register_binding.dart';
import 'package:alamuti/domain/binding/splash_screen_binding.dart';
import 'package:alamuti/domain/binding/user_advertisement_binding.dart';
import 'package:alamuti/presentation/Login/login.dart';
import 'package:alamuti/presentation/Login/register.dart';
import 'package:alamuti/presentation/advetisement_form_page/advertisement_form_page.dart';
import 'package:alamuti/presentation/chat/chatgroup.dart';
import 'package:alamuti/presentation/details/detail_page.dart';
import 'package:alamuti/presentation/home/screen/home_screen.dart';
import 'package:alamuti/presentation/myalamuti/about_alamuti.dart';
import 'package:alamuti/presentation/myalamuti/contactus.dart';
import 'package:alamuti/presentation/myalamuti/myalamuti_page.dart';
import 'package:alamuti/presentation/myalamuti/user_advertisement.dart';
import 'package:alamuti/presentation/post_ads_category/category_submit_advertisement.dart';
import 'package:alamuti/presentation/splash_screen/splash_screen.dart';
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
    page: () => HomeScreen(),
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
    page: () => Registration(),
    transition: trans.Transition.noTransition,
    binding: RegisterPageBinding(),
  ),
  GetPage(
      name: "/login",
      page: () => Login(),
      transition: trans.Transition.noTransition,
      binding: LoginPageBinding()),
];
