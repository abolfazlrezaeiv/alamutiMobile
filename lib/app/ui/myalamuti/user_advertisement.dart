import 'dart:convert';
import 'package:alamuti/app/binding/advertisement_update_binding.dart';
import 'package:alamuti/app/controller/Connection_controller.dart';
import 'package:alamuti/app/controller/ads_form_controller.dart';
import 'package:alamuti/app/controller/user_advertisement_controller.dart';
import 'package:alamuti/app/controller/update_image_advertisement_controller.dart';
import 'package:alamuti/app/data/provider/advertisement_provider.dart';
import 'package:alamuti/app/ui/advetisement_form_page/advertisement_update_from_page.dart';
import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:alamuti/app/ui/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class UserAdvertisement extends StatelessWidget {
  UserAdvertisement({
    Key? key,
  }) : super(key: key);

  final double width = Get.width;
  final double height = Get.height;

  @override
  Widget build(BuildContext context) {
    ConnectionController connectionController = Get.put(ConnectionController());

    var advertisementProvider = AdvertisementProvider();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      advertisementProvider.getUserAds(context);
    });

    var advertisementTypeController = AdvertisementTypeController();

    connectionController.checkConnectionStatus();

    var myAdvertisementController = Get.put(UserAdvertisementController());

    var updateUploadImageController = Get.put(UpdateUploadImageController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AlamutiAppBar(
        appBar: AppBar(),
        title: 'آگهی های من',
        backwidget: "/myalamuti",
        hasBackButton: true,
      ),
      bottomNavigationBar: AlamutBottomNavBar(),
      body: (!connectionController.isConnected.value)
          ? Center(
              child: Text('لطفا اتصال به اینترنت همراه خود را بررسی کنید'),
            )
          : Obx(
              () => RefreshIndicator(
                onRefresh: () {
                  return advertisementProvider.getUserAds(context);
                },
                child: ListView.builder(
                  itemCount: myAdvertisementController.adsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: height / 5,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: width / 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FittedBox(
                                fit: BoxFit.fill,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: (myAdvertisementController
                                              .adsList[index].photo1 ==
                                          null)
                                      ? Opacity(
                                          opacity: 0.6,
                                          child: Image.asset(
                                            'assets/logo/no-image.png',
                                            fit: BoxFit.cover,
                                            height: height / 6,
                                            width: height / 6,
                                          ),
                                        )
                                      : Image.memory(
                                          base64Decode(
                                            myAdvertisementController
                                                .adsList[index].photo1!,
                                          ),
                                          fit: BoxFit.cover,
                                          height: height / 6,
                                          width: height / 6,
                                        ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: height / 70),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        myAdvertisementController
                                            .adsList[index].title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14),
                                        textDirection: TextDirection.rtl,
                                        overflow: TextOverflow.visible,
                                      ),
                                      SizedBox(
                                        height: height / 18,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          myAdvertisementController
                                                      .adsList[index]
                                                      .published ==
                                                  false
                                              ? Container(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5.0,
                                                        vertical: 2),
                                                    child: Text(
                                                      'در صف انتشار',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          fontSize: width / 28,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.greenAccent,
                                                      width: 0.7,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(5),
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                          SizedBox(
                                            width: width / 45,
                                          ),
                                          Row(
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  Get.defaultDialog(
                                                    radius: 5,
                                                    title:
                                                        'از حذف آگهی مطمعن هستید؟',
                                                    barrierDismissible: false,
                                                    titlePadding:
                                                        EdgeInsets.all(20),
                                                    titleStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 16,
                                                    ),
                                                    content: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        'آگهی به طور کامل حذف میشود و قابل بازگشت نیست',
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    cancel: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: TextButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        child: Text(
                                                          'انصراف',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.green),
                                                        ),
                                                      ),
                                                    ),
                                                    confirm: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: TextButton(
                                                          onPressed: () async {
                                                            Get.back();
                                                            await advertisementProvider
                                                                .deleteAds(
                                                                    id: myAdvertisementController
                                                                        .adsList[
                                                                            index]
                                                                        .id,
                                                                    context:
                                                                        context);
                                                          },
                                                          child: Text(
                                                            'حذف',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontSize: 14,
                                                                color:
                                                                    Colors.red),
                                                          )),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  'حذف',
                                                  style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.8),
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                    Color.fromRGBO(
                                                        255, 0, 0, 0.4),
                                                  ),
                                                  shape:
                                                      MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  if (myAdvertisementController
                                                          .adsList[index]
                                                          .adsType ==
                                                      AdsFormState.FOOD
                                                          .toString()) {
                                                    advertisementTypeController
                                                            .formState.value =
                                                        AdsFormState.FOOD;
                                                  }
                                                  if (myAdvertisementController
                                                          .adsList[index]
                                                          .adsType ==
                                                      AdsFormState.JOB
                                                          .toString()) {
                                                    advertisementTypeController
                                                            .formState.value =
                                                        AdsFormState.JOB;
                                                  }
                                                  if (myAdvertisementController
                                                          .adsList[index]
                                                          .adsType ==
                                                      AdsFormState.REALSTATE
                                                          .toString()) {
                                                    advertisementTypeController
                                                            .formState.value =
                                                        AdsFormState.REALSTATE;
                                                  }
                                                  updateUploadImageController
                                                          .leftImagebyteCode
                                                          .value =
                                                      myAdvertisementController
                                                              .adsList[index]
                                                              .photo1 ??
                                                          '';
                                                  updateUploadImageController
                                                          .rightImagebyteCode
                                                          .value =
                                                      myAdvertisementController
                                                              .adsList[index]
                                                              .photo2 ??
                                                          '';
                                                  Get.to(
                                                      () => AdvertisementUpdateForm(
                                                          ads:
                                                              myAdvertisementController
                                                                      .adsList[
                                                                  index]),
                                                      binding:
                                                          AdvertisementUpdateFormBinding(),
                                                      transition:
                                                          Transition.fadeIn);
                                                },
                                                child: Text(
                                                  'ویرایش',
                                                  style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.8),
                                                    fontWeight: FontWeight.w200,
                                                  ),
                                                ),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                    Color.fromRGBO(
                                                        10, 210, 71, 0.4),
                                                  ),
                                                  shape:
                                                      MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
