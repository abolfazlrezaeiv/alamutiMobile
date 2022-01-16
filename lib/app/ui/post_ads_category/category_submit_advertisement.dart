import 'package:alamuti/app/controller/ads_form_controller.dart';
import 'package:alamuti/app/controller/selected_tap_controller.dart';
import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:alamuti/app/ui/widgets/bottom_navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategorySubmitAds extends StatelessWidget {
  CategorySubmitAds({Key? key}) : super(key: key);
  final AdvertisementTypeController advertisementTypeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AlamutiAppBar(
        appBar: AppBar(),
        title: 'انتخاب دسته بندی',
        hasBackButton: false,
      ),
      bottomNavigationBar: AlamutBottomNavBar(),
      body: WillPopScope(
        onWillPop: () async {
          Get.put(ScreenController()).selectedIndex.value = 3;
          Get.toNamed('/home');

          return false;
        },
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                advertisementTypeController.formState.value = AdsFormState.FOOD;
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
                advertisementTypeController.formState.value = AdsFormState.JOB;
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
                advertisementTypeController.formState.value =
                    AdsFormState.REALSTATE;
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
