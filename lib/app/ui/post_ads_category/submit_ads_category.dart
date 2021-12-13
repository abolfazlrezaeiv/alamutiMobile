import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:alamuti/app/ui/widgets/bottom_navbar.dart';
import 'package:alamuti/app/controller/selectedTapController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../category.dart';

class SubmitAdsCategory extends StatefulWidget {
  SubmitAdsCategory({Key? key}) : super(key: key);

  @override
  State<SubmitAdsCategory> createState() => _SubmitAdsCategoryState();
}

class _SubmitAdsCategoryState extends State<SubmitAdsCategory> {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return GetBuilder<ScreenController>(
      builder: (controller) {
        return Scaffold(
          appBar: AlamutiAppBar(
            appBar: AppBar(),
            title: 'ثبت آگهی',
            hasBackButton: false,
          ),
          bottomNavigationBar: AlamutBottomNavBar(),
          body: Category(
            mq: mq,
            title: 'دسته بندی آگهی خود را انتخاب کنید',
          ),
        );
      },
    );
  }
}
