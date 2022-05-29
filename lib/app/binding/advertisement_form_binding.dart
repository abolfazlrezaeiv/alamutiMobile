import 'package:alamuti/app/controller/ads_form_controller.dart';
import 'package:alamuti/app/controller/upload_image_controller.dart';
import 'package:get/get.dart';

class FormAdvertisementBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<UploadImageController>(UploadImageController());
    Get.put<AdvertisementTypeController>(AdvertisementTypeController());
  }
}
