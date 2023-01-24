import 'package:alamuti/controller/category_tag_selected_item_controller.dart';
import 'package:alamuti/controller/search_controller.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<CategoryFilterController>(CategoryFilterController());

    Get.lazyPut<SearchController>(() => SearchController());
  }
}
