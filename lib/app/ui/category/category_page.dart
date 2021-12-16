import 'package:alamuti/app/ui/category.dart';
import 'package:alamuti/app/controller/selectedTapController.dart';
import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../widgets/bottom_navbar.dart';

class AlamutCategoryPage extends StatefulWidget {
  AlamutCategoryPage({Key? key}) : super(key: key);

  @override
  State<AlamutCategoryPage> createState() => _AlamutCategoryPageState();
}

class _AlamutCategoryPageState extends State<AlamutCategoryPage> {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return GetBuilder<ScreenController>(
      builder: (controller) {
        return Scaffold(
            appBar: AlamutiAppBar(
              appBar: AppBar(),
              title: 'دسته بندی',
              hasBackButton: false,
            ),
            bottomNavigationBar: AlamutBottomNavBar(),
            body: Category(
              mq: mq,
              title: 'دسته بندی مورد نظر خود را انتخاب کنید',
            ));
      },
    );
  }
}
