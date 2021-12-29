import 'package:alamuti/app/controller/adsFormController.dart';
import 'package:alamuti/app/ui/advetisement_form_page/advertisement_form_page.dart';
import 'package:alamuti/app/ui/home/home_page.dart';
import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:alamuti/app/ui/widgets/alamuti_button.dart';
import 'package:alamuti/app/ui/widgets/bottom_navbar.dart';
import 'package:alamuti/app/controller/selectedTapController.dart';
import 'package:alamuti/app/ui/widgets/category_items.dart';
import 'package:flutter/cupertino.dart';
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
  AdsFormState? adsItems = AdsFormState.FOOD;

  String? dropDownChoice = 'میوه و مواد غذایی';

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    var filterType = [
      '',
      AdsFormState.FOOD.toString(),
      AdsFormState.JOB.toString(),
      AdsFormState.REALSTATE.toString()
    ];
    List<String> options = [
      'میوه و مواد غذایی',
      'مشاغل',
      'املاک',
    ];
    var formType = [
      AdsFormState.FOOD,
      AdsFormState.JOB,
      AdsFormState.REALSTATE
    ];
    return GetBuilder<ScreenController>(
      builder: (controller) {
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
              // Container(
              //   padding: EdgeInsets.all(Get.height / 40),
              //   alignment: Alignment.centerRight,
              //   child: Text(
              //     'انتخاب دسته بندی',
              //     style: TextStyle(
              //       fontSize: 18,
              //       fontWeight: FontWeight.w300,
              //     ),
              //     textDirection: TextDirection.rtl,
              //   ),
              // ),
              GestureDetector(
                onTap: () {
                  adsFormController.formState.value = AdsFormState.FOOD;
                  Get.to(AdvertisementForm());
                },
                child: Container(
                  child: Column(
                    children: [
                      Divider(),
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
                  Get.to(AdvertisementForm());
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
                  Get.to(AdvertisementForm());
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

          // body: Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 20.0),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       SizedBox(
          //         height: 15,
          //       ),
          //       Container(
          //         color: Colors.white,
          //         width: mq.width,
          //         padding: EdgeInsets.only(right: 20),
          //         child: Text(
          //           'دسته بندی آگهی خود را انتخاب کنید',
          //           style: TextStyle(
          //             fontSize: 16,
          //             fontWeight: FontWeight.w300,
          //           ),
          //           textDirection: TextDirection.rtl,
          //         ),
          //       ),
          //       SizedBox(
          //         height: 20,
          //       ),

          //       DropdownButton<String>(
          //         value: dropDownChoice,
          //         items: options.map((String value) {
          //           return DropdownMenuItem<String>(
          //             value: value,
          //             child: Text(value),
          //           );
          //         }).toList(),
          //         onChanged: (value) {
          //           adsFormController.formState.value =
          //               formType[options.indexOf(value!)];

          //           setState(() {
          //             dropDownChoice = value;
          //           });
          //         },
          //       ),
          //       Padding(
          //         padding: EdgeInsets.symmetric(
          //             horizontal: 10.0, vertical: Get.height / 38),
          //         child: SizedBox(
          //           width: Get.width,
          //           height: Get.height / 16,
          //           child: TextButton(
          //             onPressed: () {
          //               Get.to(AdvertisementForm(),
          //                   transition: Transition.noTransition);
          //             },
          //             child: Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 40.0),
          //               child: Text(
          //                 'ادامه',
          //                 style: TextStyle(color: Colors.white.withOpacity(1)),
          //               ),
          //             ),
          //             style: ButtonStyle(
          //               backgroundColor: MaterialStateProperty.all(
          //                 Color.fromRGBO(8, 212, 76, 0.3),
          //               ),
          //               shape:
          //                   MaterialStateProperty.all<RoundedRectangleBorder>(
          //                 RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(3.0),
          //                   side: BorderSide(
          //                     color: Color.fromRGBO(8, 212, 76, 0.5),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       )
          // Column(
          //   children: categoryItems
          //       .map(
          //         (x) => GestureDetector(
          //           onTap: () {
          //             if (x.state == AdsFormState.FOOD) {
          //               adsFormController.formState.value =
          //                   AdsFormState.FOOD;
          //             }
          //             if (x.state == AdsFormState.JOB) {
          //               adsFormController.formState.value =
          //                   AdsFormState.JOB;
          //             }
          //             if (x.state == AdsFormState.REALSTATE) {
          //               adsFormController.formState.value =
          //                   AdsFormState.REALSTATE;
          //             }
          //             Get.to(AdvertisementForm());
          //           },
          //           child: Card(
          //             elevation: 0.3,
          //             child: Padding(
          //               padding: const EdgeInsets.all(20.0),
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.end,
          //                 children: [
          //                   Text(
          //                     x.title,
          //                     textDirection: TextDirection.rtl,
          //                     style: TextStyle(
          //                         fontSize: 17,
          //                         fontWeight: FontWeight.w600),
          //                   ),
          //                   SizedBox(
          //                     width: 15,
          //                   ),
          //                   Container(
          //                     child: Icon(
          //                       x.icon,
          //                       color: Colors.grey,
          //                       size: 40,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ),
          //       )
          //       .toList(),
          // ),
        );
      },
    );
  }
}

enum SingingCharacter { lafayette, jefferson }

class CategoryItem {
  final IconData icon;
  final String title;

  CategoryItem({required this.icon, required this.title});
}


                // GestureDetector(
                //   onTap: () {
                //     adsFormController.formState.value = AdsFormState.FOOD;
                //     setState(() {
                //       adsItems = AdsFormState.FOOD;
                //     });
                //   },
                //   child: SizedBox(
                //     width: Get.width / 2,
                //     child: Card(
                //       elevation: 2,
                //       child: Row(
                //         children: [
                //           Expanded(
                //             child: const Text(
                //               'میوه و موادغذایی',
                //               textDirection: TextDirection.rtl,
                //             ),
                //           ),
                //           Container(
                //             width: 82,
                //             child: ListTile(
                //               leading: Radio<AdsFormState>(
                //                 value: AdsFormState.FOOD,
                //                 groupValue: adsItems,
                //                 activeColor: Color.fromRGBO(8, 212, 76, 0.7),
                //                 onChanged: (AdsFormState? value) {
                //                   adsFormController.formState.value =
                //                       AdsFormState.FOOD;
                //                   setState(() {
                //                     adsItems = value;
                //                   });
                //                 },
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // GestureDetector(
                //   onTap: () {
                //     adsFormController.formState.value = AdsFormState.JOB;
                //     setState(() {
                //       adsItems = AdsFormState.JOB;
                //     });
                //   },
                //   child: SizedBox(
                //     width: Get.width / 2,
                //     child: Card(
                //       elevation: 2,
                //       child: Row(
                //         children: [
                //           Expanded(
                //             child: const Text(
                //               'ایجاد آگهی شغلی',
                //               textDirection: TextDirection.rtl,
                //             ),
                //           ),
                //           Container(
                //             width: 82,
                //             child: ListTile(
                //               leading: Radio<AdsFormState>(
                //                 value: AdsFormState.JOB,
                //                 groupValue: adsItems,
                //                 activeColor: Color.fromRGBO(8, 212, 76, 0.7),
                //                 onChanged: (AdsFormState? value) {
                //                   adsFormController.formState.value =
                //                       AdsFormState.JOB;
                //                   setState(() {
                //                     adsItems = value;
                //                   });
                //                 },
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),

                // GestureDetector(
                //   onTap: () {
                //     adsFormController.formState.value = AdsFormState.REALSTATE;
                //     setState(() {
                //       adsItems = AdsFormState.REALSTATE;
                //     });
                //   },
                //   child: SizedBox(
                //     width: Get.width / 2,
                //     child: Card(
                //       elevation: 2,
                //       child: Row(
                //         children: [
                //           Expanded(
                //             child: const Text(
                //               'املاک',
                //               textDirection: TextDirection.rtl,
                //             ),
                //           ),
                //           Container(
                //             width: 82,
                //             child: ListTile(
                //               leading: Radio<AdsFormState>(
                //                 value: AdsFormState.REALSTATE,
                //                 groupValue: adsItems,
                //                 activeColor: Color.fromRGBO(8, 212, 76, 0.7),
                //                 onChanged: (AdsFormState? value) {
                //                   adsFormController.formState.value =
                //                       AdsFormState.REALSTATE;
                //                   setState(() {
                //                     adsItems = value;
                //                   });
                //                 },
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),