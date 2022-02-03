import 'package:alamuti/app/controller/detail_page_advertisement.dart';
import 'package:get/get.dart';

class DetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<DetailPageController>(DetailPageController());
  }
}
