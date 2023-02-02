import 'package:alamuti/domain/controllers/chat_info_controller.dart';
import 'package:alamuti/domain/controllers/detail_page_advertisement.dart';
import 'package:get/get.dart';

class DetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<DetailPageController>(DetailPageController());
    Get.put<ChatInfoController>(ChatInfoController());
  }
}
