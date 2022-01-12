import 'package:alamuti/app/controller/advertisement_controller.dart';
import 'package:alamuti/app/controller/category_tag_selected_item_controller.dart';
import 'package:alamuti/app/controller/scroll_position.dart';
import 'package:alamuti/app/controller/search_avoid_update.dart';
import 'package:alamuti/app/controller/selected_category_filter_controller.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HomeScrollController>(HomeScrollController());

    Get.lazyPut<CategorySelectedFilterController>(
        () => CategorySelectedFilterController());

    Get.lazyPut<CategorySelectedChipsController>(
        () => CategorySelectedChipsController());

    Get.put<ListAdvertisementController>(ListAdvertisementController());

    Get.lazyPut<CheckIsSearchedController>(() => CheckIsSearchedController());
  }
}
