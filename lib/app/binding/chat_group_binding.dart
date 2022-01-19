import 'package:alamuti/app/controller/chat_group_controller.dart';
import 'package:alamuti/app/controller/new_message_controller.dart';
import 'package:get/get.dart';

class ChatGroupBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<NewMessageController>(NewMessageController(), permanent: true);
    Get.put<ChatGroupController>(ChatGroupController());
  }
}
