import 'package:alamuti/app/controller/chat_message_controller.dart';
import 'package:alamuti/app/controller/chat_target_controller.dart';
import 'package:alamuti/app/controller/detail_page_advertisement.dart';
import 'package:get/get.dart';

class DetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatTargetUserController>(() => ChatTargetUserController());

    Get.lazyPut<ChatMessageController>(() => ChatMessageController());

    Get.put<DetailPageController>(DetailPageController());
  }
}
