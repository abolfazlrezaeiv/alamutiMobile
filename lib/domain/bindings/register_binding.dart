import 'package:alamuti/domain/controllers/login_controller.dart';
import 'package:alamuti/domain/controllers/otp_request_controller.dart';
import 'package:get/get.dart';

class RegisterPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<OTPRequestController>(OTPRequestController());
    Get.put<LoginViewModel>(LoginViewModel());
  }
}
