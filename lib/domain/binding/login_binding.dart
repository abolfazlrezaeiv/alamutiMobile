import 'package:alamuti/domain/controller/login_controller.dart';
import 'package:alamuti/domain/controller/otp_request_controller.dart';
import 'package:get/get.dart';

class LoginPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<OTPRequestController>(OTPRequestController());
    Get.put<LoginViewModel>(LoginViewModel());
  }
}
