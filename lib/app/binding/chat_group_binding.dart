import 'package:alamuti/app/controller/chat_info_controller.dart';
import 'package:get/get.dart';

class ChatGroupBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ChatInfoController>(ChatInfoController());
  }
}
