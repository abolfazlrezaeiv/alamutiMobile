import 'package:alamuti/controller/upload_image_controller.dart';
import 'package:get/get.dart';

class FormAdvertisementBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<UploadImageController>(UploadImageController());
  }
}
