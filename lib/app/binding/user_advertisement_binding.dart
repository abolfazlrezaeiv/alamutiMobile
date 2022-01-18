import 'package:alamuti/app/controller/ads_form_controller.dart';
import 'package:alamuti/app/controller/advertisement_controller.dart';
import 'package:alamuti/app/controller/advertisement_pagination_controller.dart';
import 'package:alamuti/app/controller/update_image_advertisement_controller.dart';
import 'package:get/get.dart';

class UserAdvertisementBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ListAdvertisementController>(ListAdvertisementController());

    Get.lazyPut<UpdateUploadImageController>(
        () => UpdateUploadImageController());

    Get.lazyPut<AdvertisementPaginationController>(
        () => AdvertisementPaginationController());

    Get.lazyPut<AdvertisementTypeController>(
        () => AdvertisementTypeController());
  }
}
