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
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromRGBO(8, 212, 76, 0.5),
            title: Text(
              'ثبت آگهی',
              style: TextStyle(fontSize: 19),
              textDirection: TextDirection.rtl,
            ),
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
