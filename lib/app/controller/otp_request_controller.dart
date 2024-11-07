import 'package:get/get.dart';

class OTPRequestController extends GetxController {
  var canRequestOTP = false.obs;
  var phoneNumber = ''.obs;
  var isPhoneNumber = false.obs;
  var isSendingSms = false.obs;
  var isOTP = false.obs;
}
