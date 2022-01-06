import 'package:get/state_manager.dart';

class UploadImageController extends GetxController {
  var isFirstOneSelected = false.obs;
  var imageCounter = 0.obs;
  var rightImagebyteCode = ''.obs;
  var leftImagebyteCode = ''.obs;

  void getImage(String image) {
    imageCounter.value++;
    if (imageCounter.value == 1) {
      leftImagebyteCode.value = image;
    } else if (imageCounter.value == 2) {
      rightImagebyteCode.value = image;
    } else if (imageCounter > 2) {
      if (rightImagebyteCode.value.length < 2) {
        rightImagebyteCode.value = image;
      } else if (leftImagebyteCode.value.length < 2) {
        leftImagebyteCode.value = image;
      }
    }
  }
}
