import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:alamuti/app/controller/adsFormController.dart';
import 'package:alamuti/app/controller/price_with_symbol.dart';
import 'package:alamuti/app/controller/selectedTapController.dart';
import 'package:alamuti/app/controller/upload_image_controller.dart';
import 'package:alamuti/app/data/provider/advertisement_provider.dart';
import 'package:alamuti/app/ui/post_ads_category/submit_ads_category.dart';
import 'package:alamuti/app/ui/theme.dart';
import 'package:alamuti/app/ui/widgets/add_ads_photo_card.dart';
import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:alamuti/app/ui/widgets/alamuti_textfield.dart';
import 'package:alamuti/app/ui/widgets/description_textfield.dart';
import 'package:alamuti/app/ui/widgets/photo_card_left.dart';
import 'package:alamuti/app/ui/widgets/photo_card_right.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdvertisementForm extends StatefulWidget {
  @override
  State<AdvertisementForm> createState() => _AdvertisementFormState();
}

class _AdvertisementFormState extends State<AdvertisementForm> {
  var adsFormController = Get.put(AdsFormController());

  var screenController = Get.put(ScreenController());

  var uploadImageController = Get.put(UploadImageController());

  var priceController = Get.put(PriceController());

  final GlobalKey<FormState> _formKey = GlobalKey();

  var priceTextFieldController = TextEditingController();

  var titleTextFieldController = TextEditingController();

  var vilageNameTextFieldController = TextEditingController();

  var areaTextFieldController = TextEditingController();

  var descriptionTextFieldController = TextEditingController();

  var advertisementProvider = AdvertisementProvider();

  Uint8List? logoBase64;
  var pickedFile;

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
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: Get.height / 45,
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
              height: Get.height / 45,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'عنوان آگهی',
                        style: TextStyle(
                            fontSize: Get.width / 28,
                            fontWeight: FontWeight.w400),
                        textDirection: TextDirection.rtl,
                      ),
                      SizedBox(height: Get.height / 65),
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
                SizedBox(height: Get.height / 80),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width / 35),
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
            SizedBox(height: Get.height / 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
                  child: getPriceTextFieldTitle(),
                ),
                SizedBox(
                  height: Get.height / 80,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width / 35),
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
                SizedBox(height: Get.height / 40),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
                  child: Text(
                    'نام روستا',
                    style: TextStyle(
                        fontSize: Get.width / 28, fontWeight: FontWeight.w400),
                    textDirection: TextDirection.rtl,
                  ),
                ),
                SizedBox(
                  height: Get.height / 80,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width / 35),
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
                  height: Get.height / 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'توضیحات آگهی',
                        style: TextStyle(
                            fontSize: Get.width / 28,
                            fontWeight: FontWeight.w400),
                        textDirection: TextDirection.rtl,
                      ),
                      SizedBox(height: Get.height / 65),
                      Text(
                        'جزئیات و نکات قابل توجه آگهی خود را کامل و دقیق بنویسید',
                        style: TextStyle(
                            fontSize: Get.width / 31,
                            fontWeight: FontWeight.w300),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height / 80),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width / 35),
                  child: DescriptionTextField(
                      textEditingController: descriptionTextFieldController),
                ),
              ],
            ),
            SizedBox(
              height: Get.height / 80,
            ),
            Container(
              padding: EdgeInsets.only(
                  right: Get.width / 2,
                  left: Get.width / 35,
                  bottom: Get.width / 35),
              child: TextButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(10, 210, 71, 0.5),
                  minimumSize: Size(88, 36),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await advertisementProvider.postAdvertisement(
                      area: areaTextFieldController.text.isEmpty
                          ? 0
                          : int.parse(areaTextFieldController.text),
                      village: vilageNameTextFieldController.text,
                      description: descriptionTextFieldController.text,
                      photo1: uploadImageController.leftImagebyteCode.value,
                      photo2: uploadImageController.rightImagebyteCode.value,
                      price: int.parse(priceTextFieldController.text),
                      title: titleTextFieldController.text,
                    );
                    screenController.selectedIndex.value = 0;
                    Get.toNamed('/myads');
                  }
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
          ],
        ),
      ),
    );
  }

  Widget getAreaTextField() {
    return adsFormController.formState.value.toString() ==
            AdsFormState.REALSTATE.toString()
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: Get.height / 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width / 28),
                child: Text(
                  "متراژ",
                  style: TextStyle(
                      fontSize: Get.width / 28, fontWeight: FontWeight.w400),
                  textDirection: TextDirection.rtl,
                ),
              ),
              SizedBox(
                height: Get.height / 80,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width / 35),
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

  Widget getPersianPriceHint() {
    var commaAddedPrice = priceController.price.value
        .split('')
        .reversed
        .join()
        .replaceAllMapped(RegExp(r".{3}"), (match) => "${match.group(0)},")
        .split('')
        .reversed
        .join();
    if (commaAddedPrice.startsWith(',')) {
      commaAddedPrice = commaAddedPrice.substring(1, commaAddedPrice.length);
    }
    if (commaAddedPrice.endsWith(',')) {
      commaAddedPrice =
          commaAddedPrice.substring(0, commaAddedPrice.length - 1);
    }

    var result = commaAddedPrice;

    return Text(
      priceController.price.isNotEmpty ? 'تومان $result' : '',
      style: TextStyle(
          fontSize: Get.width / 31,
          fontWeight: FontWeight.w300,
          fontFamily: persianNumber),
      textDirection: TextDirection.rtl,
    );
  }

  String titleTextfiledPrefix() {
    var prifix;
    if (adsFormController.formState.value == AdsFormState.FOOD) {
      prifix = 'مثال : "گیلاس آتان"';
    }
    if (adsFormController.formState.value == AdsFormState.JOB) {
      prifix = 'مثال : "راننده با ماشین"';
    }
    if (adsFormController.formState.value == AdsFormState.REALSTATE) {
      prifix = 'مثال : "زمین کشاورزی"';
    }
    return prifix;
  }

  chooseImage() async {
    var image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 700,
        maxWidth: 700);
    if (image != null) {
      final bytes = File(image.path).readAsBytesSync();

      String img64 = base64Encode(bytes);

      uploadImageController.getImage(img64);
    } else {
      print('picked image is null');
    }
  }

  Widget getPriceTextFieldTitle() {
    var title;
    if (adsFormController.formState.value == AdsFormState.FOOD) {
      title = 'قیمت';
    }
    if (adsFormController.formState.value == AdsFormState.JOB) {
      title = 'حقوق ماهیانه';
    }
    if (adsFormController.formState.value == AdsFormState.REALSTATE) {
      title = 'قیمت کل';
    }
    return Text(
      title,
      style: TextStyle(fontSize: Get.width / 28, fontWeight: FontWeight.w400),
      textDirection: TextDirection.rtl,
    );
  }
}
