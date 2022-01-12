import 'package:alamuti/app/controller/ads_form_controller.dart';
import 'package:alamuti/app/controller/update_image_advertisement_controller.dart';
import 'package:alamuti/app/controller/user_advertisement_controller.dart';
import 'package:get/get.dart';

class UserAdvertisementBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<UserAdvertisementController>(UserAdvertisementController());

    Get.lazyPut<UpdateUploadImageController>(
        () => UpdateUploadImageController());

    Get.lazyPut<AdvertisementTypeController>(
        () => AdvertisementTypeController());
  }
}
