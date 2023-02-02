import 'package:alamuti/domain/controller/upload_image_controller.dart';
import 'package:get/get.dart';

class FormAdvertisementBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<UploadImageController>(UploadImageController());
  }
}
