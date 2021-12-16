import 'package:get/state_manager.dart';

class UploadImageController extends GetxController {
  final isFirstOneSelected = false.obs;
  final imageCounter = 0.obs;
  final image1byteCode = ''.obs;
  final image2byteCode = ''.obs;

  void getImage(String image) {
    imageCounter.value++;
    if (imageCounter.value == 1) {
      image1byteCode.value = image;
      print('first image uploaded');
    } else if (imageCounter.value == 2) {
      image2byteCode.value = image;
      print('second image uploaded');
    } else if (imageCounter > 2) {
      image2byteCode.value = image;
      print('please remove other items');
    }
  }

  void resetImageCounter() {
    imageCounter.value = 0;
    image1byteCode.value = '';
    image2byteCode.value = '';
  }
}
