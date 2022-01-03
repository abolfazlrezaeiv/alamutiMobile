import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:alamuti/app/controller/adsFormController.dart';
import 'package:alamuti/app/controller/selectedTapController.dart';
import 'package:alamuti/app/controller/update_image_advertisement.dart';
import 'package:alamuti/app/data/model/Advertisement.dart';
import 'package:alamuti/app/data/provider/advertisement_provider.dart';
import 'package:alamuti/app/ui/post_ads_category/submit_ads_category.dart';
import 'package:alamuti/app/ui/theme.dart';
import 'package:alamuti/app/ui/widgets/add_ads_photo_card.dart';
import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:alamuti/app/ui/widgets/alamuti_textfield.dart';
import 'package:alamuti/app/ui/widgets/description_textfield.dart';
import 'package:alamuti/app/ui/widgets/update_image_card_left.dart';
import 'package:alamuti/app/ui/widgets/update_image_card_right.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdvertisementUpdateForm extends StatefulWidget {
  final Advertisement ads;

  const AdvertisementUpdateForm({Key? key, required this.ads})
      : super(key: key);
  @override
  State<AdvertisementUpdateForm> createState() =>
      _AdvertisementUpdateFormState();
}

class _AdvertisementUpdateFormState extends State<AdvertisementUpdateForm> {
  var adsFormController = Get.put(AdsFormController());

  var screenController = Get.put(ScreenController());

  var updateUploadImageController = Get.put(UpdateUploadImageController());

  final GlobalKey<FormState> formKey = GlobalKey();

  var advertisementProvider = AdvertisementProvider();

  late TextEditingController titleTextFieldController;

  late TextEditingController priceTextFieldController;

  late TextEditingController areaTextFieldController;

  late TextEditingController descriptionTextFieldController;
  var photo1;
  var photo2;
  @override
  initState() {
    super.initState();

    titleTextFieldController = TextEditingController(text: widget.ads.title);
    priceTextFieldController =
        TextEditingController(text: widget.ads.price.toString());

    areaTextFieldController = TextEditingController(text: widget.ads.area);

    descriptionTextFieldController =
        TextEditingController(text: widget.ads.description);
  }

  Uint8List? logoBase64;
  var pickedFile;

  @override
  void dispose() {
    super.dispose();
    updateUploadImageController.resetImageCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AlamutiAppBar(
        title: 'ثبت آگهی',
        hasBackButton: true,
        appBar: AppBar(),
        backwidget: SubmitAdsCategory(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width / 40),
        child: Form(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(Get.height / 60),
                      alignment: Alignment.centerRight,
                      child: Text(
                        'عکس آگهی',
                        style: TextStyle(
                          fontSize: Get.width / 25,
                          fontWeight: FontWeight.w400,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                    Container(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        UpdateLeftPhotoCard(),
                        UpdateRightPhotoCard(),
                        GestureDetector(
                            onTap: () {
                              chooseImage();
                            },
                            child: AddPhotoWidget()),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: Get.width / 40.0, bottom: 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'عنوان آگهی',
                          style: TextStyle(
                              fontSize: Get.width / 25,
                              fontWeight: FontWeight.w400),
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(
                          height: Get.height / 65,
                        ),
                        Text(
                          'در عنوان آگهی به موارد مهم و چشمگیر اشاره کنید',
                          style: TextStyle(
                              fontSize: Get.width / 31,
                              fontWeight: FontWeight.w300),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height / 80,
                  ),
                  AlamutiTextField(
                    textEditingController: titleTextFieldController,
                    isNumber: false,
                  ),
                ],
              ),
              SizedBox(
                height: Get.height / 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  getPriceTextFieldTitle(),
                  SizedBox(
                    height: Get.height / 80,
                  ),
                  AlamutiTextField(
                    textEditingController: priceTextFieldController,
                    isNumber: true,
                  ),
                ],
              ),
              SizedBox(
                height: Get.height / 40,
              ),
              getAreaTextField(areaTextFieldController),
              SizedBox(
                height: Get.height / 40,
              ),
              Text(
                ' توضیحات آگهی',
                style: TextStyle(
                    fontSize: Get.width / 25, fontWeight: FontWeight.w400),
                textDirection: TextDirection.rtl,
              ),
              SizedBox(
                height: Get.height / 65,
              ),
              Text(
                'جزئیات و نکات قابل توجه آگهی خود را کامل و دقیق بنویسید',
                style: TextStyle(
                    fontSize: Get.width / 31, fontWeight: FontWeight.w300),
                textDirection: TextDirection.rtl,
              ),
              SizedBox(
                height: Get.height / 80,
              ),
              DescriptionTextField(
                  textEditingController: descriptionTextFieldController),
              Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height / 35.0),
                child: Container(
                  padding: EdgeInsets.only(right: Get.width / 2),
                  child: TextButton(
                    style: ElevatedButton.styleFrom(
                      primary: alamutPrimaryColor,
                      minimumSize: Size(88, 36),
                    ),
                    onPressed: () async {
                      await advertisementProvider.updateAdvertisement(
                        area: areaTextFieldController.text.isEmpty
                            ? 0
                            : int.parse(areaTextFieldController.text),
                        description: descriptionTextFieldController.text,
                        photo1:
                            updateUploadImageController.leftImagebyteCode.value,
                        photo2: updateUploadImageController
                            .rightImagebyteCode.value,
                        price: int.parse(priceTextFieldController.text
                            .replaceAll(RegExp(r','), '')),
                        title: titleTextFieldController.text,
                        id: widget.ads.id,
                      );

                      Get.toNamed('/home');
                    },
                    child: Text(
                      'ثبت',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: Get.width / 25,
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

  Widget getAreaTextField(TextEditingController textEditingController) {
    return adsFormController.formState.value == AdsFormState.REALSTATE
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(top: Get.width / 40.0, bottom: 3),
                child: Text(
                  "متراژ",
                  style: TextStyle(
                      fontSize: Get.width / 27, fontWeight: FontWeight.w300),
                  textDirection: TextDirection.rtl,
                ),
              ),
              AlamutiTextField(
                textEditingController: textEditingController,
                isNumber: true,
              ),
            ],
          )
        : Container();
  }

  chooseImage() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      final bytes = File(image.path).readAsBytesSync();

      String img64 = base64Encode(bytes);

      updateUploadImageController.getImage(img64);
    } else {
      print('picked image is null');
    }
  }

  Widget getPriceTextFieldTitle() {
    var title;
    if (adsFormController.formState.value == AdsFormState.FOOD) {
      title = 'قیمت (به تومان)';
    }
    if (adsFormController.formState.value == AdsFormState.JOB) {
      title = 'حقوق ماهیانه';
    }
    if (adsFormController.formState.value == AdsFormState.REALSTATE) {
      title = 'قیمت کل';
    }
    return Padding(
      padding: EdgeInsets.only(top: Get.width / 35.0, bottom: 3),
      child: Text(
        title,
        style: TextStyle(fontSize: Get.width / 25, fontWeight: FontWeight.w400),
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
