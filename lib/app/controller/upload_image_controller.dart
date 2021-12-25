import 'package:get/state_manager.dart';

class UploadImageController extends GetxController {
  final isFirstOneSelected = false.obs;
  final imageCounter = 0.obs;
  final rightImagebyteCode = ''.obs;
  final leftImagebyteCode = ''.obs;

  void getImage(String image) {
    imageCounter.value++;
    if (imageCounter.value == 1) {
      rightImagebyteCode.value = image;
    } else if (imageCounter.value == 2) {
      leftImagebyteCode.value = image;
    } else if (imageCounter > 2) {
      if (rightImagebyteCode.value.length < 2) {
        rightImagebyteCode.value = image;
      } else if (leftImagebyteCode.value.length < 2) {
        leftImagebyteCode.value = image;
      }
    }
  }

  getRightImage() {
    return rightImagebyteCode;
  }

  getLeftImage() {
    return leftImagebyteCode;
  }

  // void resetImageCounter() {
  //   imageCounter.value = 0;
  //   image1byteCode.value = '';
  //   image2byteCode.value = '';
  // }
}
