import 'package:alamuti/app/controller/update_image_advertisement_controller.dart';

import 'package:get/get.dart';

class AdvertisementUpdateFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<UpdateUploadImageController>(UpdateUploadImageController());
  }
}
