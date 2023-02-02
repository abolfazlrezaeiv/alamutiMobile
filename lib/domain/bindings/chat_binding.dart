import 'package:alamuti/domain/controllers/chat_info_controller.dart';
import 'package:alamuti/domain/controllers/selected_tap_controller.dart';
import 'package:get/get.dart';

class ChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ScreenController>(ScreenController());
    Get.put<ChatInfoController>(ChatInfoController());
  }
}
