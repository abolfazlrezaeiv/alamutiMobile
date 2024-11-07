import 'package:alamuti/app/controller/category_tag_selected_item_controller.dart';
import 'package:alamuti/app/controller/search_controller.dart';
import 'package:alamuti/app/controller/text_focus_controller.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<CategoryFilterController>(CategoryFilterController());
    Get.put<TextFocusController>(TextFocusController());
    Get.lazyPut<SearchKeywordController>(() => SearchKeywordController());
  }
}
