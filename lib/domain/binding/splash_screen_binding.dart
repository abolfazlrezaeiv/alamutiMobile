import 'package:alamuti/domain/controller/authentication_manager_controller.dart';
import 'package:get/get.dart';

class SplashScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthenticationManager>(AuthenticationManager(), permanent: true);
  }
}
