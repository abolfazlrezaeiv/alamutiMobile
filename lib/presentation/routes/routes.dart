import 'package:alamuti/domain/bindings/advertisement_form_binding.dart';
import 'package:alamuti/domain/bindings/category_submit_ads_binding.dart';
import 'package:alamuti/domain/bindings/chat_group_binding.dart';
import 'package:alamuti/domain/bindings/detail_binding.dart';
import 'package:alamuti/domain/bindings/home_binding.dart';
import 'package:alamuti/domain/bindings/login_binding.dart';
import 'package:alamuti/domain/bindings/register_binding.dart';
import 'package:alamuti/domain/bindings/splash_screen_binding.dart';
import 'package:alamuti/domain/bindings/user_advertisement_binding.dart';
import 'package:alamuti/presentation/advertisement_mutations/advertisement_form_page.dart';
import 'package:alamuti/presentation/advertisement_mutations/publish_category_screen.dart';
import 'package:alamuti/presentation/auth/login_screen.dart';
import 'package:alamuti/presentation/auth/register_screen.dart';
import 'package:alamuti/presentation/chat/chat_mainscreen.dart';
import 'package:alamuti/presentation/details/detail_screen.dart';
import 'package:alamuti/presentation/home/screens/home_screen.dart';
import 'package:alamuti/presentation/myalamuti/about_alamuti_screen.dart';
import 'package:alamuti/presentation/myalamuti/alamuti_main_screen.dart';
import 'package:alamuti/presentation/myalamuti/contact_screen.dart';
import 'package:alamuti/presentation/myalamuti/user_advertisement_screen.dart';
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
    page: () => DetailScreen(),
    binding: DetailPageBinding(),
    transition: trans.Transition.fadeIn,
  ),
  GetPage(
    name: '/add_ads',
    page: () => PublishCategoryScreen(),
    transition: trans.Transition.noTransition,
    binding: CategorySubmitAdsBinding(),
  ),
  GetPage(
    name: "/chat",
    page: () => ChatMainScreen(),
    binding: ChatGroupBinding(),
    transition: trans.Transition.noTransition,
  ),
  GetPage(
    name: "/myads",
    page: () => UserAdvertisementScreen(),
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
    page: () => MyAlamutiMainScreen(),
    transition: trans.Transition.noTransition,
  ),
  GetPage(
    name: "/about",
    page: () => AboutAlamutiScreen(),
    transition: trans.Transition.noTransition,
  ),
  GetPage(
    name: "/contact",
    page: () => ContactUsScreen(),
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
