import 'package:alamuti/bottom_navbar.dart';
import 'package:alamuti/category.dart';
import 'package:alamuti/selectedTapController.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

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
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Color.fromRGBO(8, 212, 76, 0.5),
              title: Text(
                'دسته بندی',
                style: TextStyle(fontSize: 19),
              ),
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
