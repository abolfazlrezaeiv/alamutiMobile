import 'package:alamuti/app/controller/adsFormController.dart';
import 'package:alamuti/app/ui/home/home_page.dart';
import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:alamuti/app/ui/widgets/bottom_navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmitAdsCategory extends StatefulWidget {
  SubmitAdsCategory({Key? key}) : super(key: key);

  @override
  State<SubmitAdsCategory> createState() => _SubmitAdsCategoryState();
}

class _SubmitAdsCategoryState extends State<SubmitAdsCategory> {
  AdsFormController adsFormController = Get.put(AdsFormController());

  AdsFormState? adsItems = AdsFormState.FOOD;

  String? dropDownChoice = 'میوه و مواد غذایی';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AlamutiAppBar(
        appBar: AppBar(),
        backwidget: HomePage(),
        title: 'انتخاب دسته بندی',
        hasBackButton: false,
      ),
      bottomNavigationBar: AlamutBottomNavBar(),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              adsFormController.formState.value = AdsFormState.FOOD;
              Get.toNamed('/ads_form');
            },
            child: Container(
              child: Column(
                children: [
                  Divider(
                    color: Colors.transparent,
                  ),
                  ListTile(
                    leading: Icon(CupertinoIcons.back),
                    title: Text(
                      'موادغذایی',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    trailing: Icon(CupertinoIcons.bag),
                  ),
                  Divider(),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              adsFormController.formState.value = AdsFormState.JOB;
              Get.toNamed('/ads_form');
            },
            child: Container(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(CupertinoIcons.back),
                    title: Text(
                      'مشاغل',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    trailing: Icon(CupertinoIcons.person_3_fill),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              adsFormController.formState.value = AdsFormState.REALSTATE;
              Get.toNamed('/ads_form');
            },
            child: Container(
              child: Column(
                children: [
                  Divider(),
                  ListTile(
                    leading: Icon(CupertinoIcons.back),
                    title: Text(
                      'املاک',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    trailing: Icon(CupertinoIcons.house),
                  ),
                  Divider(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

enum SingingCharacter { lafayette, jefferson }

class CategoryItem {
  final IconData icon;
  final String title;

  CategoryItem({required this.icon, required this.title});
}
