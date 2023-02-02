import 'package:alamuti/domain/controller/ads_form_controller.dart';
import 'package:alamuti/domain/controller/selected_tap_controller.dart';
import 'package:alamuti/presentation/widgets/alamuti_appbar.dart';
import 'package:alamuti/presentation/widgets/bottom_navbar.dart';
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
          Get.offNamed('/home');

          return false;
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              CategoryItem(
                advertisementTypeController: advertisementTypeController,
                category: AdsFormState.FOOD,
                categoryIcon: Icon(
                  CupertinoIcons.bag,
                  size: Get.width / 16,
                ),
                categoryName: 'موادغذایی',
              ),
              CategoryItem(
                advertisementTypeController: advertisementTypeController,
                categoryName: 'دام و حیوانات محلی',
                category: AdsFormState.Trap,
                categoryIcon: Container(
                  width: Get.width / 16,
                  child: Opacity(
                    opacity: 0.5,
                    child: Image.asset(
                      'assets/icons/sheep.png',
                    ),
                  ),
                ),
              ),
              CategoryItem(
                advertisementTypeController: advertisementTypeController,
                categoryName: 'خدمات',
                category: AdsFormState.JOB,
                categoryIcon: Icon(
                  CupertinoIcons.person_3,
                  size: Get.width / 16,
                ),
              ),
              CategoryItem(
                advertisementTypeController: advertisementTypeController,
                categoryName: 'املاک',
                category: AdsFormState.REALSTATE,
                categoryIcon: Icon(
                  CupertinoIcons.house,
                  size: Get.width / 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String categoryName;
  final Widget categoryIcon;
  final AdsFormState category;
  const CategoryItem({
    Key? key,
    required this.advertisementTypeController,
    required this.categoryName,
    required this.categoryIcon,
    required this.category,
  }) : super(key: key);

  final AdvertisementTypeController advertisementTypeController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        advertisementTypeController.formState.value = category;
        Get.toNamed('/ads_form');
      },
      child: Container(
        child: Column(
          children: [
            ListTile(
              leading: Icon(CupertinoIcons.back),
              title: Text(
                categoryName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                textDirection: TextDirection.rtl,
              ),
              trailing: categoryIcon,
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
