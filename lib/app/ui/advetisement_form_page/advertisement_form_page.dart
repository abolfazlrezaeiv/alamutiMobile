import 'dart:convert';
import 'dart:io';
import 'package:alamuti/app/controller/ads_form_controller.dart';
import 'package:alamuti/app/controller/upload_image_controller.dart';
import 'package:alamuti/app/data/provider/advertisement_provider.dart';
import 'package:alamuti/app/ui/widgets/add_ads_photo_card.dart';
import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:alamuti/app/ui/widgets/alamuti_textfield.dart';
import 'package:alamuti/app/ui/widgets/description_textfield.dart';
import 'package:alamuti/app/ui/widgets/photo_card_left.dart';
import 'package:alamuti/app/ui/widgets/photo_card_right.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdvertisementForm extends GetView<UploadImageController> {
  final areaTextFieldController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController priceTextFieldController =
      TextEditingController();

  final TextEditingController titleTextFieldController =
      TextEditingController();

  final TextEditingController vilageNameTextFieldController =
      TextEditingController();

  final TextEditingController descriptionTextFieldController =
      TextEditingController();

  final AdvertisementProvider advertisementProvider = AdvertisementProvider();

  final double width = Get.width;

  final double height = Get.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AlamutiAppBar(
        title: 'ثبت آگهی',
        hasBackButton: true,
        appBar: AppBar(),
        backwidget: '/add_ads',
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: height / 45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    LeftPhotoCard(),
                    RightPhotoCard(),
                    GestureDetector(
                        onTap: () {
                          chooseImage();
                        },
                        child: AddPhotoWidget()),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: height / 45,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'عنوان آگهی',
                        style: TextStyle(
                            fontSize: width / 28, fontWeight: FontWeight.w400),
                        textDirection: TextDirection.rtl,
                      ),
                      SizedBox(height: height / 65),
                      Text(
                        'در عنوان آگهی به موارد مهم و چشمگیر اشاره کنید',
                        style: TextStyle(
                            fontSize: width / 31, fontWeight: FontWeight.w300),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height / 80),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 35),
                  child: AlamutiTextField(
                    textEditingController: titleTextFieldController,
                    isNumber: false,
                    isChatTextField: false,
                    isPrice: false,
                    hasCharacterLimitation: true,
                    prefix: titleTextfiledPrefix(),
                  ),
                ),
              ],
            ),
            SizedBox(height: height / 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 25),
                  child: getPriceTextFieldTitle(),
                ),
                SizedBox(
                  height: height / 80,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 35),
                  child: AlamutiTextField(
                    textEditingController: priceTextFieldController,
                    isNumber: true,
                    isPrice: true,
                    isChatTextField: false,
                    hasCharacterLimitation: true,
                    prefix: 'تومان',
                  ),
                ),
              ],
            ),
            getAreaTextField(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: height / 40),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 25),
                  child: Text(
                    'نام روستا',
                    style: TextStyle(
                        fontSize: width / 28, fontWeight: FontWeight.w400),
                    textDirection: TextDirection.rtl,
                  ),
                ),
                SizedBox(
                  height: height / 80,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 35),
                  child: AlamutiTextField(
                    textEditingController: vilageNameTextFieldController,
                    isNumber: false,
                    isPrice: false,
                    isChatTextField: false,
                    hasCharacterLimitation: true,
                    prefix: 'مثال : وناش بالا',
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: height / 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'توضیحات آگهی',
                        style: TextStyle(
                            fontSize: width / 28, fontWeight: FontWeight.w400),
                        textDirection: TextDirection.rtl,
                      ),
                      SizedBox(height: height / 65),
                      Text(
                        'جزئیات و نکات قابل توجه آگهی خود را کامل و دقیق بنویسید',
                        style: TextStyle(
                            fontSize: width / 31, fontWeight: FontWeight.w300),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height / 80),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 35),
                  child: DescriptionTextField(
                      textEditingController: descriptionTextFieldController),
                ),
              ],
            ),
            SizedBox(
              height: height / 80,
            ),
            Container(
              padding: EdgeInsets.only(
                  right: width / 2, left: width / 35, bottom: width / 35),
              child: TextButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(10, 210, 71, 0.5),
                  minimumSize: Size(88, 36),
                ),
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  if (_formKey.currentState!.validate()) {
                    await advertisementProvider.postAdvertisement(
                      context: context,
                      area: areaTextFieldController.text.isEmpty
                          ? 0
                          : int.parse(areaTextFieldController.text),
                      village: vilageNameTextFieldController.text,
                      description: descriptionTextFieldController.text,
                      photo1: controller.leftImagebyteCode.value,
                      photo2: controller.rightImagebyteCode.value,
                      price: int.parse(
                          priceTextFieldController.text.replaceAll(',', '')),
                      title: titleTextFieldController.text,
                    );
                  }
                  controller.leftImagebyteCode.value = '';
                  controller.rightImagebyteCode.value = '';
                },
                child: Text(
                  'ثبت',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: width / 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getAreaTextField() {
    var advertisementTypeController = Get.put(AdvertisementTypeController());

    return advertisementTypeController.formState.value.toString() ==
            AdsFormState.REALSTATE.toString()
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: height / 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width / 28),
                child: Text(
                  "متراژ",
                  style: TextStyle(
                      fontSize: width / 28, fontWeight: FontWeight.w400),
                  textDirection: TextDirection.rtl,
                ),
              ),
              SizedBox(
                height: height / 80,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width / 35),
                child: AlamutiTextField(
                  textEditingController: areaTextFieldController,
                  isNumber: true,
                  isPrice: false,
                  isChatTextField: false,
                  hasCharacterLimitation: true,
                  prefix: 'متر',
                ),
              ),
            ],
          )
        : Container();
  }

  String titleTextfiledPrefix() {
    var advertisementTypeController = Get.put(AdvertisementTypeController());

    var prifix;
    if (advertisementTypeController.formState.value == AdsFormState.FOOD) {
      prifix = 'مثال : "گیلاس آتان"';
    }
    if (advertisementTypeController.formState.value == AdsFormState.JOB) {
      prifix = 'مثال : "راننده با ماشین"';
    }
    if (advertisementTypeController.formState.value == AdsFormState.REALSTATE) {
      prifix = 'مثال : "زمین کشاورزی"';
    }
    return prifix;
  }

  chooseImage() async {
    var uploadImageController = Get.put(UploadImageController());

    var image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 40,
        maxHeight: 600,
        maxWidth: 600);
    if (image != null) {
      final bytes = File(image.path).readAsBytesSync();

      String img64 = base64Encode(bytes);

      uploadImageController.getImage(img64);
    } else {
      print('picked image is null');
    }
  }

  Widget getPriceTextFieldTitle() {
    var advertisementTypeController = Get.put(AdvertisementTypeController());

    var title;
    if (advertisementTypeController.formState.value == AdsFormState.FOOD) {
      title = 'قیمت';
    }
    if (advertisementTypeController.formState.value == AdsFormState.JOB) {
      title = 'حقوق ماهیانه';
    }
    if (advertisementTypeController.formState.value == AdsFormState.REALSTATE) {
      title = 'قیمت کل';
    }
    return Text(
      title,
      style: TextStyle(fontSize: width / 28, fontWeight: FontWeight.w400),
      textDirection: TextDirection.rtl,
    );
  }
}
