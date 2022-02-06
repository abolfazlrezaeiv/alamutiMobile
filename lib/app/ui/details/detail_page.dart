import 'dart:convert';
import 'dart:typed_data';
import 'package:alamuti/app/controller/ads_form_controller.dart';
import 'package:alamuti/app/controller/detail_page_advertisement.dart';
import 'package:alamuti/app/data/provider/advertisement_provider.dart';
import 'package:alamuti/app/data/provider/signalr_helper.dart';
import 'package:alamuti/app/data/storage/cache_manager.dart';
import 'package:alamuti/app/ui/chat/chat.dart';
import 'package:alamuti/app/ui/details/fullscreen_image.dart';
import 'package:alamuti/app/ui/details/fullscreen_slider.dart';
import 'package:alamuti/app/ui/theme.dart';
import 'package:alamuti/app/ui/widgets/description_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class AdsDetail extends StatefulWidget {
  final int id;

  AdsDetail({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<AdsDetail> createState() => _AdsDetailState();
}

class _AdsDetailState extends State<AdsDetail> with CacheManager {
  final DetailPageController detailPageController = Get.find();

  TextEditingController reportTextEditingCtrl = TextEditingController();

  final double width = Get.width;

  final double height = Get.height;

  final AdvertisementProvider advertisementProvider = AdvertisementProvider();

  final SignalRHelper signalRHelper = SignalRHelper(
    handler: () => print('created in detail'),
  );

  final GetStorage storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 300,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Row(
          children: [
            Icon(
              CupertinoIcons.back,
              size: width / 20,
              color: Colors.black,
            ),
            Text(
              'بازگشت',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: width / 23),
            )
          ],
        ),
      ),

        backgroundColor: Colors.transparent,
      ) ,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: Obx(
        () => ListView(
          padding: EdgeInsets.zero,
          physics: ClampingScrollPhysics(),
          children: [
            Column(
              children: [
                ((detailPageController.details[0].photo1 != null) &&
                        (detailPageController.details[0].photo2 != null))
                    ? getImageSlider()
                    : getImageOrEmpty(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width / 20,
                  ),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: height / 55,
                          ),
                          child: Text(
                            detailPageController.details[0].title,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: width / 24),
                            textDirection: TextDirection.rtl,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        Text(
                          detailPageController.details[0].village +
                              ' ' +
                              detailPageController.details[0].datePosted.trim(),
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontFamily: persianNumber,
                              fontSize: width / 31),
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(
                          height: height / 55,
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: width / 55),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${detailPageController.details[0].price} تومان',
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                    fontSize: width / 26,
                                    fontFamily: persianNumber,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                getPriceTitle(),
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: width / 27),
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        getAreaRealState(),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showReportDialog(context) {
                                AlertDialog alert = AlertDialog(
                                    backgroundColor: Colors.white,
                                    elevation: 0,
                                    content: Container(
                                      height: height / 2.9,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'درباره مشکل توضیح دهید.',
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: width / 30,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 5,
                                              ),
                                              DescriptionTextField(
                                                  textEditingController:
                                                      reportTextEditingCtrl),
                                              TextButton(
                                                  onPressed: () async {
                                                    Get.back();
                                                    await advertisementProvider
                                                        .sendReport(
                                                      context: context,
                                                      id: detailPageController
                                                          .details[0].id,
                                                      report:
                                                          reportTextEditingCtrl
                                                              .text,
                                                    );
                                                  },
                                                  child: Text(
                                                    'ثبت گزارش',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.greenAccent,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ));
                                showDialog(
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return alert;
                                  },
                                  context: context,
                                );
                              }

                              return showReportDialog(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: Colors.greenAccent, width: 0.5)),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Row(
                                  children: [
                                    Text(
                                      'گزارش مشکل آگهی',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.grey,
                                          fontSize: width / 31),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Icon(
                                      CupertinoIcons
                                          .exclamationmark_circle_fill,
                                      color: Colors.greenAccent,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'توضیحات',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: width / 24),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height / 55,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          detailPageController.details[0].description,
                          maxLines: 6,
                          overflow: TextOverflow.visible,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: width / 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 6,
        child:  Padding(
        padding:
        EdgeInsets.symmetric(horizontal: 8.0, vertical: height / 50),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () async {
                _makePhoneCall(
                    detailPageController.details[0].phoneNumber);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width / 6, vertical: Get.width / 90),
                child: Text(
                  'تماس',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Color.fromRGBO(10, 210, 71, 0.4),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                var chatImage = await _getListviewImage();

                var groupName = detailPageController.details[0].userId +
                    await getUserId() +
                    detailPageController.details[0].title;

                await signalRHelper.initializeChat(
                    receiverId: detailPageController.details[0].userId,
                    senderId: await getUserId(),
                    groupname: groupName,
                    groupImage: chatImage,
                    grouptitle: detailPageController.details[0].title);

                Get.to(
                        () => Chat(
                      groupImage: chatImage,
                      receiverId:
                      detailPageController.details[0].userId,
                      groupTitle:
                      detailPageController.details[0].title,
                      groupname: groupName,
                      signalRHelper: signalRHelper,
                    ),
                    transition: Transition.fadeIn);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width / 6.0,
                    vertical: Get.width / 90),
                child: Text(
                  'چت',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Color.fromRGBO(10, 210, 71, 0.4),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      ),
    );
  }

  Future<String> _getListviewImage() async {
    String imageForListView = '';
    if (detailPageController.details[0].photo1 != null) {
      imageForListView = detailPageController.details[0].photo1;
    }
    if (detailPageController.details[0].photo2 != null) {
      imageForListView = detailPageController.details[0].photo2;
    }
    if (imageForListView.length > 2) {
      imageForListView =
          base64Encode(await _comporessList(base64Decode(imageForListView)));
    }
    return imageForListView;
  }

  Future<Uint8List> _comporessList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minWidth: 120,
      minHeight: 67,
      quality: 7,
      rotate: 0,
    );

    return result;
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  Widget getImageSlider() {
    return ImageSlideshow(
      width: double.infinity,
      height: height / 2.5,
      initialPage: 0,
      indicatorColor: Colors.greenAccent,
      indicatorBackgroundColor: Colors.white,
      children: [
        GestureDetector(
          onTap: () {
            Get.to(
              () => FullscreenImageSlider(
                image1: detailPageController.details[0].photo1!,
                image2: detailPageController.details[0].photo2!,
              ),
            );
          },
          child: ShaderMask(
            shaderCallback: (rect) {
              return RadialGradient(
                colors: [Colors.transparent, Colors.white],
              ).createShader(
                  Rect.fromLTRB(-200, -200, Get.width / 2, Get.width / 2));
            },
            blendMode: BlendMode.dstIn,
            child: Image.memory(
              base64Decode(detailPageController.details[0].photo1!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.to(
              () => FullscreenImageSlider(
                image1: detailPageController.details[0].photo1!,
                image2: detailPageController.details[0].photo2!,
              ),
            );
          },
          child: ShaderMask(
            shaderCallback: (rect) {
              return RadialGradient(
                colors: [Colors.transparent, Colors.white],
              ).createShader(Rect.fromLTRB(-200, -200, width / 2, width / 2));
            },
            blendMode: BlendMode.dstIn,
            child: Image.memory(
              base64Decode(detailPageController.details[0].photo2!),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
      autoPlayInterval: null,
      isLoop: true,
    );
  }

  Widget getImageOrEmpty() {
    if (detailPageController.details[0].photo1 != null) {
      return singleImage(detailPageController.details[0].photo1);
    }

    if (detailPageController.details[0].photo2 != null) {
      return singleImage(detailPageController.details[0].photo2);
    }

    return getAppbarWithBack();
  }

  Widget singleImage(String? image) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => FullscreenImage(image: image!),
        );
      },
      child: Container(
        height: height / 2.5,
        width: width,
        child: ShaderMask(
          shaderCallback: (rect) {
            return RadialGradient(
              colors: [Colors.transparent, Colors.white],
            ).createShader(
                Rect.fromLTRB(-200, -200, Get.width / 2, Get.width / 2));
          },
          blendMode: BlendMode.dstIn,
          child: Image.memory(
            base64Decode(image!),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  String getPriceTitle() {
    if (detailPageController.details[0].adsType ==
        AdsFormState.FOOD.toString().toLowerCase()) {
      return 'قیمت';
    }
    if (detailPageController.details[0].adsType ==
        AdsFormState.JOB.toString().toLowerCase()) {
      return 'حقوق ماهیانه';
    }

    return 'قیمت کل';
  }

  Widget getAreaRealState() {
    return (detailPageController.details[0].adsType ==
            AdsFormState.REALSTATE.toString().toLowerCase())
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: width / 55),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${detailPageController.details[0].area} متر',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          fontSize: width / 26,
                          fontFamily: persianNumber,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "متراژ",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: width / 27,
                          fontFamily: persianNumber),
                    )
                  ],
                ),
              ),
              Divider(),
            ],
          )
        : Container();
  }

  Widget getAppbarWithBack() {
    return Card(
      margin: EdgeInsets.all(0),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      color: Color.fromRGBO(8, 212, 76, 0.5),
      child: Padding(
        padding: EdgeInsets.only(top: 40.0, bottom: 20),
        child: Opacity(
          opacity: 0.5,
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.back,
                  size: width / 20,
                  color: Colors.black,
                ),
                Text(
                  'بازگشت',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: width / 23),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
