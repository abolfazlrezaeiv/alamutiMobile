import 'dart:convert';
import 'package:alamuti/app/controller/ads_form_controller.dart';
import 'package:alamuti/app/controller/chat_message_controller.dart';
import 'package:alamuti/app/controller/chat_target_controller.dart';
import 'package:alamuti/app/ui/chat/newchat.dart';
import 'package:alamuti/app/ui/details/fullscreen_image.dart';
import 'package:alamuti/app/ui/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AdsDetail extends StatelessWidget {
  final ChatTargetUserController chatTargetUserController = Get.find();

  final ChatMessageController chatMessageController = Get.find();

  final double width = Get.width;

  final double height = Get.height;

  final String? byteImage1;
  final String? byteImage2;
  final String phoneNumber;
  final String title;
  final String price;
  final String sendedDate;
  final String userId;
  final String description;
  final String adsType;
  final String area;
  final String village;
  AdsDetail(
      {Key? key,
      required this.byteImage1,
      required this.byteImage2,
      required this.title,
      required this.price,
      required this.description,
      required this.userId,
      required this.sendedDate,
      required this.adsType,
      required this.area,
      required this.village,
      required this.phoneNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              ((byteImage1 != null) && (byteImage2 != null))
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
                          title,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: width / 24),
                          textDirection: TextDirection.rtl,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      Text(
                        village + ' ' + sendedDate.trim(),
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
                              '$price تومان',
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
                    Text(
                      'توضیحات',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: width / 24),
                    ),
                    SizedBox(
                      height: height / 55,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        description,
                        maxLines: 7,
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
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 8.0, vertical: height / 50),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () async {
                    _makePhoneCall(this.phoneNumber);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width / 5.6, vertical: Get.width / 90),
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
                  onPressed: () {
                    chatTargetUserController.saveUserId(userId);
                    chatMessageController.messageList.clear();
                    Get.to(
                        () => NewChat(
                            receiverId: chatTargetUserController.userId.value,
                            groupImage: this.byteImage1,
                            groupTitle: this.title),
                        transition: Transition.fadeIn);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width / 5.6, vertical: Get.width / 90),
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
          )
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  Widget getImageSlider() {
    return Stack(children: [
      ImageSlideshow(
        width: double.infinity,
        height: height / 3,
        initialPage: 0,
        indicatorColor: Colors.greenAccent,
        indicatorBackgroundColor: Colors.white,
        children: [
          GestureDetector(
            onTap: () {
              Get.to(
                () => FullscreenImage(image: byteImage1!),
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
                base64Decode(byteImage1!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(
                () => FullscreenImage(image: byteImage2!),
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
                base64Decode(byteImage2!),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
        autoPlayInterval: null,
        isLoop: true,
      ),
      Container(
        padding: EdgeInsets.only(top: width / 12, left: width / 45),
        width: width,
        height: height / 3,
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: () => Get.toNamed('/home'),
          child: Container(
            width: Get.width / 5,
            color: Colors.transparent,
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.back,
                  size: 25,
                  color: Colors.black,
                ),
                Text(
                  'بازگشت',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                )
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  Widget getImageOrEmpty() {
    return (byteImage1 != null)
        ? GestureDetector(
            onTap: () {
              Get.to(
                () => FullscreenImage(image: byteImage1!),
              );
            },
            child: Stack(children: [
              Container(
                height: height / 2.5,
                width: width,
                child: Image.memory(
                  base64Decode(byteImage1!),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: width / 12, left: width / 45),
                width: width,
                height: height / 2.5,
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Get.toNamed('/home'),
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.back,
                        size: 25,
                        color: Colors.black,
                      ),
                      Text(
                        'بازگشت',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
            ]),
          )
        : getAppbarWithBack();
  }

  String getPriceTitle() {
    if (adsType == AdsFormState.FOOD.toString().toLowerCase()) {
      return 'قیمت';
    }
    if (adsType == AdsFormState.JOB.toString().toLowerCase()) {
      return 'حقوق ماهیانه';
    }

    return 'قیمت کل';
  }

  Widget getAreaRealState() {
    return (adsType == AdsFormState.REALSTATE.toString().toLowerCase())
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
                      '$area متر',
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
    return Container(
      color: Color.fromRGBO(8, 212, 76, 0.5),
      child: Padding(
        padding: EdgeInsets.only(top: 40.0, bottom: 20),
        child: Opacity(
          opacity: 0.5,
          child: GestureDetector(
            onTap: () => Get.toNamed('/home'),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.back,
                  size: 25,
                  color: Colors.black,
                ),
                Text(
                  'بازگشت',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getStackedBackButton() {
    return Padding(
      padding: EdgeInsets.only(top: 40.0),
      child: Opacity(
        opacity: 0.7,
        child: GestureDetector(
          onTap: () => Get.toNamed('/home'),
          child: Container(
            width: width / 4,
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.back,
                  size: 25,
                  color: Colors.white,
                ),
                Text(
                  'بازگشت',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
