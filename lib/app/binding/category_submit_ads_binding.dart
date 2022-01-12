import 'package:alamuti/app/controller/ads_form_controller.dart';
import 'package:get/get.dart';

class CategorySubmitAdsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AdvertisementTypeController>(AdvertisementTypeController());
  }
}
