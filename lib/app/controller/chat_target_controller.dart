import 'package:get/get.dart';

class ChatTargetUserController extends GetxController {
  final userId = ''.obs;

  void saveUserId(String userid) {
    userId.value = userid;
  }
}
