import 'dart:convert';
import 'dart:typed_data';
import 'package:alamuti/app/controller/ads_form_controller.dart';
import 'package:alamuti/app/controller/chat_info_controller.dart';
import 'package:alamuti/app/controller/detail_page_advertisement.dart';
import 'package:alamuti/app/data/provider/advertisement_provider.dart';
import 'package:alamuti/app/data/provider/chat_message_provider.dart';
import 'package:alamuti/app/data/provider/signalr_helper.dart';
import 'package:alamuti/app/data/storage/cache_manager.dart';
import 'package:alamuti/app/ui/alert_dialog_class.dart';
import 'package:alamuti/app/ui/chat/chat.dart';
import 'package:alamuti/app/ui/details/fullscreen_image.dart';
import 'package:alamuti/app/ui/details/fullscreen_slider.dart';
import 'package:alamuti/app/ui/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class Detail extends StatefulWidget {
  Detail({
    Key? key,
  }) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> with CacheManager {
  final DetailPageController detailPageController = Get.find();

  final ChatInfoController chatInfoController = Get.find();

  TextEditingController reportTextEditingCtrl = TextEditingController();

  final AdvertisementProvider advertisementProvider = AdvertisementProvider();

  final messageProvider = MessageProvider();

  final SignalRHelper signalRHelper = SignalRHelper(
    handler: () => print('created in detail'),
  );

  final GetStorage storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    var hasImage = (detailPageController.details[0].photo1 != null) &&
        (detailPageController.details[0].photo2 != null);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 8,
        foregroundColor: Colors.white,
        shadowColor: Colors.grey,
        backgroundColor: Color.fromRGBO(78, 198, 122, 1.0),
      ),
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: false,
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
                    horizontal: Get.width / 20,
                  ),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: Get.height / 55,
                          ),
                          child: Text(
                            detailPageController.details[0].title,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: Get.width / 24),
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
                              fontSize: Get.width / 31),
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(
                          height: Get.height / 55,
                        ),
                        Divider(),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: Get.width / 55),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${detailPageController.details[0].price} تومان',
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                    fontSize: Get.width / 26,
                                    fontFamily: persianNumber,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                getPriceTitle(),
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: Get.width / 27),
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
                  padding: EdgeInsets.symmetric(horizontal: Get.width / 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              return Alert.showAdvertisementReportDialog(
                                  context,
                                  reportTextEditingCtrl,
                                  detailPageController.details[0].id);
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
                                          fontSize: Get.width / 31),
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
                                fontSize: Get.width / 24),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height / 55,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          detailPageController.details[0].description,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: Get.width / 28,
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
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 8.0, vertical: Get.height / 50),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: FractionallySizedBox(
                  widthFactor: 1,
                  heightFactor: 0.1 / 1.7,
                  child: ElevatedButton(
                    onPressed: () async {
                      await _makePhoneCall(
                          detailPageController.details[0].phoneNumber);
                    },
                    child: Text(
                      'تماس',
                      style: TextStyle(
                        color: Color.fromRGBO(88, 77, 77, 1.0),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: FractionallySizedBox(
                  widthFactor: 1,
                  heightFactor: 0.1 / 1.7,
                  child: ElevatedButton(
                    onPressed: () async {
                      print('1');
                      var chatImage = await _getListviewImage();
                      print('2');
                      var groupName = detailPageController.details[0].userId +
                          '_' +
                          await getUserId() +
                          '_' +
                          detailPageController.details[0].title;
                      print('3');

                      await signalRHelper.initializeChat(
                          receiverId: detailPageController.details[0].userId,
                          senderId: await getUserId(),
                          groupname: groupName,
                          groupImage: chatImage,
                          grouptitle: detailPageController.details[0].title);

                      var group = await messageProvider.getGroup(groupName);

                      print('4');
                      if (group != null && group.isDeleted == true) {
                        var message = 'مخاطب مکالمه را حذف کرده است';
                        Alert.showDeletedMessageDialog(
                            context: context, message: message);
                      } else if (group != null && group.isDeleted == false) {
                        chatInfoController.chat.value = [group];

                        Get.to(() => Chat(signalRHelper: signalRHelper),
                            transition: Transition.fadeIn);
                      }
                    },
                    child: Text(
                      'چت',
                      style: TextStyle(
                        color: Color.fromRGBO(88, 77, 77, 1.0),
                        fontWeight: FontWeight.w400,
                      ),
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
          base64Encode(await _compressList(base64Decode(imageForListView)));
    }
    return imageForListView;
  }

  Future<Uint8List> _compressList(Uint8List list) async {
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
      height: Get.height / 2.2,
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
          child: Image.memory(
            base64Decode(detailPageController.details[0].photo1!),
            fit: BoxFit.cover,
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
          child: Image.memory(
            base64Decode(detailPageController.details[0].photo2!),
            fit: BoxFit.cover,
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
    return emptyImage();
  }

  Widget emptyImage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Opacity(
          opacity: 0.2,
          child: Container(
            height: Get.height / 2.9,
            width: Get.width,
            decoration: BoxDecoration(
              // color: Colors.grey,
              border: Border.all(color: Colors.grey, width: 5),
            ),
            child: Image.asset(
              'assets/logo/no-image.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget singleImage(String? image) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => FullscreenImage(image: image!),
        );
      },
      child: Container(
        height: Get.height / 2.2,
        width: Get.width,
        child: Image.memory(
          base64Decode(image!),
          fit: BoxFit.cover,
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
                padding: EdgeInsets.symmetric(vertical: Get.width / 55),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${detailPageController.details[0].area} متر',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          fontSize: Get.width / 26,
                          fontFamily: persianNumber,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "متراژ",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: Get.width / 27,
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

  // Widget getAppbarWithBack() {
  //   return Card(
  //     margin: EdgeInsets.all(0),
  //     elevation: 0,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(0.0),
  //     ),
  //     color: Colors.transparent,
  //     child: Container(
  //       width: Get.width,
  //       height: Get.height/8,
  //     ),
  //   );
  // }
}
