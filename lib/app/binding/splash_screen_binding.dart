import 'package:alamuti/app/controller/authentication_manager_controller.dart';
import 'package:alamuti/app/data/provider/token_provider.dart';
import 'package:get/get.dart';

class SplashScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthenticationManager>(AuthenticationManager());
    Get.put<TokenProvider>(TokenProvider(), permanent: true);
  }
}
