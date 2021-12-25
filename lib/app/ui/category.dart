// import 'package:alamuti/app/controller/adsFormController.dart';
// import 'package:alamuti/app/controller/selectedTapController.dart';
// import 'package:alamuti/app/ui/advertisementForm.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'food_form/food_form.dart';
// import 'home/home_page.dart';
// import 'job_form/job_form.dart';
// import 'widgets/category_items.dart';
// import 'realstate_form/realstate_form.dart';

// class Category extends StatelessWidget {
//   const Category({
//     Key? key,
//     required this.mq,
//     required this.title,
//   }) : super(key: key);
//   final title;
//   final Size mq;

//   @override
//   Widget build(BuildContext context) {
//     final ScreenController c = Get.put(ScreenController());
//     return
//   }
// }

import 'package:alamuti/app/controller/adsFormController.dart';
import 'package:flutter/cupertino.dart';

class CategoryItem {
  final IconData icon;
  final String title;
  final AdsFormState state;

  CategoryItem({required this.state, required this.icon, required this.title});
}
