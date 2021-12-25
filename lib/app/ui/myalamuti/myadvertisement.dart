import 'dart:convert';
import 'package:alamuti/app/controller/ConnectionController.dart';
import 'package:alamuti/app/controller/adsFormController.dart';
import 'package:alamuti/app/controller/selectedTapController.dart';
import 'package:alamuti/app/data/model/Advertisement.dart';
import 'package:alamuti/app/data/provider/advertisement_provider.dart';
import 'package:alamuti/app/ui/advetisement_form_page/advertisement_update_from_page.dart';
import 'package:alamuti/app/ui/details/detail_page.dart';
import 'package:alamuti/app/ui/imgaebase64.dart';
import 'package:alamuti/app/ui/myalamuti/myalamuti_page.dart';
import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:alamuti/app/ui/widgets/appbar.dart';
import 'package:alamuti/app/ui/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class MyAdvertisement extends StatefulWidget {
  const MyAdvertisement({
    Key? key,
  }) : super(key: key);
  @override
  State<MyAdvertisement> createState() => _MyAdvertisementState();
}

class _MyAdvertisementState extends State<MyAdvertisement> {
  int selectedTap = 4;

  var ap = AdvertisementProvider();
  List<Advertisement> adsList = [];
  ConnectionController connectionController = Get.put(ConnectionController());
  ScreenController screenController = Get.put(ScreenController());
  AdvertisementProvider advertisementProvider = AdvertisementProvider();
  AdsFormController adsFormController = AdsFormController();

  @override
  void initState() {
    super.initState();
    screenController.selectedIndex = 0;
    ap.getMyAds().then((value) {
      print('its calling');
      if (value == null) {
        print('value is null');
      }
      setState(() {
        adsList = value;
      });
      print(adsList.length);
    });

    connectionController.checkConnectionStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AlamutiAppBar(
        appBar: AppBar(),
        title: 'آگهی های من',
        backwidget: MyAlamutiPage(),
        hasBackButton: true,
      ),
      bottomNavigationBar: AlamutBottomNavBar(),
      body: (!connectionController.isConnected.value)
          ? Center(
              child: Text('لطفا اتصال به اینترنت همراه خود را بررسی کنید'),
            )
          : ListView.builder(
              itemCount: adsList.length,
              itemBuilder: (BuildContext context, int index) {
                return Stack(children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.withOpacity(0.3),
                        ),
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2.2,
                              height: MediaQuery.of(context).size.height / 5,
                              child: Image.memory(
                                base64Decode(adsList[index].photo ?? image64),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 3.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    adsList[index].title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                    textDirection: TextDirection.rtl,
                                  ),
                                  SizedBox(
                                    height: 75.0,
                                  ),
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          advertisementProvider
                                              .deleteAds(adsList[index].id);
                                        },
                                        child: Text(
                                          'حذف',
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            Color.fromRGBO(255, 0, 0, 0.4),
                                          ),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          if (adsList[index].adsType ==
                                              AdsFormState.FOOD.toString()) {
                                            adsFormController.formState.value =
                                                AdsFormState.FOOD;
                                          }
                                          if (adsList[index].adsType ==
                                              AdsFormState.JOB.toString()) {
                                            adsFormController.formState.value =
                                                AdsFormState.JOB;
                                          }
                                          if (adsList[index].adsType ==
                                              AdsFormState.REALSTATE
                                                  .toString()) {
                                            adsFormController.formState.value =
                                                AdsFormState.REALSTATE;
                                          }
                                          Get.to(AdvertisementUpdateForm(
                                              ads: adsList[index]));
                                        },
                                        child: Text(
                                          'ویرایش',
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            Color.fromRGBO(10, 210, 71, 0.5),
                                          ),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Text(
                                  //   '${adsList[index].price.toString()}  تومان',
                                  //   style: TextStyle(
                                  //       fontFamily: 'IRANSansXFaNum',
                                  //       fontWeight: FontWeight.w300),
                                  // ),
                                  // Text(
                                  //   adsList[index].datePosted,
                                  //   style: TextStyle(
                                  //       fontWeight: FontWeight.w200,
                                  //       fontFamily: 'IRANSansXFaNum',
                                  //       fontSize: 14),
                                  //   textDirection: TextDirection.rtl,
                                  // ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.bottomLeft,
                  //   child: Row(
                  //     children: [
                  //       TextButton(
                  //         onPressed: () {},
                  //         child: Text('حذف'),
                  //         style: ButtonStyle(
                  //           backgroundColor: MaterialStateProperty.all(
                  //             Color.fromRGBO(255, 0, 0, 0.4),
                  //           ),
                  //         ),
                  //       ),
                  //       TextButton(
                  //         onPressed: () {},
                  //         child: Text('ویرایش'),
                  //         style: ButtonStyle(
                  //           backgroundColor: MaterialStateProperty.all(
                  //             Color.fromRGBO(10, 210, 71, 0.5),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // )
                ]);
              },
            ),
    );
  }
}
