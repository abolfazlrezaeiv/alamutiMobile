import 'package:get/get.dart';

class ScreenController extends GetxController {
  int selectedIndex = 4;

  selectIndex(int index) {
    selectedIndex = index;
    update();
  }

  getScreen() => selectedIndex;
}
