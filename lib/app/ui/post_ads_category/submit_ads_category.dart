import 'package:alamuti/app/controller/adsFormController.dart';
import 'package:alamuti/app/ui/advetisement_form_page/advertisement_form_page.dart';
import 'package:alamuti/app/ui/home/home_page.dart';
import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:alamuti/app/ui/widgets/bottom_navbar.dart';
import 'package:alamuti/app/controller/selectedTapController.dart';
import 'package:alamuti/app/ui/widgets/category_items.dart';
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
  AdsFormController adsFormController = Get.put(AdsFormController());

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return GetBuilder<ScreenController>(
      builder: (controller) {
        return Scaffold(
          appBar: AlamutiAppBar(
            appBar: AppBar(),
            backwidget: HomePage(),
            title: 'ثبت آگهی',
            hasBackButton: false,
          ),
          bottomNavigationBar: AlamutBottomNavBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: mq.width,
                    child: Text(
                      'دسته بندی آگهی خود را انتخاب کنید',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: categoryItems
                      .map(
                        (x) => GestureDetector(
                          onTap: () {
                            if (x.state == AdsFormState.FOOD) {
                              adsFormController.formState.value =
                                  AdsFormState.FOOD;
                            }
                            if (x.state == AdsFormState.JOB) {
                              adsFormController.formState.value =
                                  AdsFormState.JOB;
                            }
                            if (x.state == AdsFormState.REALSTATE) {
                              adsFormController.formState.value =
                                  AdsFormState.REALSTATE;
                            }
                            Get.to(AdvertisementForm());
                          },
                          child: Card(
                            elevation: 0.3,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    x.title,
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    child: Icon(
                                      x.icon,
                                      color: Colors.grey,
                                      size: 40,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CategoryItem {
  final IconData icon;
  final String title;

  CategoryItem({required this.icon, required this.title});
}
