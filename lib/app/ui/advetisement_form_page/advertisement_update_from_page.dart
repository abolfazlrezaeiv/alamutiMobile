import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:alamuti/app/controller/adsFormController.dart';
import 'package:alamuti/app/controller/update_image_advertisement.dart';
import 'package:alamuti/app/data/model/Advertisement.dart';
import 'package:alamuti/app/data/provider/advertisement_provider.dart';
import 'package:alamuti/app/ui/myalamuti/myadvertisement.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey();

  var advertisementProvider = AdvertisementProvider();

  late TextEditingController titleTextFieldController;

  late TextEditingController priceTextFieldController;

  late TextEditingController vilageNameTextFieldController;

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
    vilageNameTextFieldController =
        TextEditingController(text: widget.ads.village);
    descriptionTextFieldController =
        TextEditingController(text: widget.ads.description);
  }

  Uint8List? logoBase64;
  var pickedFile;

  @override
  Widget build(BuildContext context) {
    var updateUploadImageController = Get.put(UpdateUploadImageController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AlamutiAppBar(
        title: 'ثبت آگهی',
        hasBackButton: true,
        appBar: AppBar(),
        backwidget: MyAdvertisement(),
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
                  FocusScope.of(context).unfocus();
                  if (_formKey.currentState!.validate()) {
                    await advertisementProvider.updateAdvertisement(
                      context: context,
                      area: areaTextFieldController.text.isEmpty
                          ? 0
                          : int.parse(areaTextFieldController.text),
                      description: descriptionTextFieldController.text,
                      photo1:
                          updateUploadImageController.leftImagebyteCode.value,
                      photo2:
                          updateUploadImageController.rightImagebyteCode.value,
                      price: int.parse(priceTextFieldController.text
                          .replaceAll(RegExp(r','), '')),
                      village: vilageNameTextFieldController.text,
                      title: titleTextFieldController.text,
                      id: widget.ads.id,
                    );
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
    return widget.ads.adsType == AdsFormState.REALSTATE.toString().toLowerCase()
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

  chooseImage() async {
    var updateUploadImageController = Get.put(UpdateUploadImageController());

    var image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 700,
        maxWidth: 700);
    if (image != null) {
      final bytes = File(image.path).readAsBytesSync();

      String img64 = base64Encode(bytes);

      updateUploadImageController.getImage(img64);
    } else {
      print('picked image is null');
    }
  }

  String titleTextfiledPrefix() {
    var prifix;
    if (widget.ads.adsType == AdsFormState.FOOD.toString().toLowerCase()) {
      prifix = 'مثال : "گیلاس آتان"';
    }
    if (widget.ads.adsType == AdsFormState.JOB.toString().toLowerCase()) {
      prifix = 'مثال : "راننده با ماشین"';
    }
    if (widget.ads.adsType == AdsFormState.REALSTATE.toString().toLowerCase()) {
      prifix = 'مثال : "زمین کشاورزی"';
    }
    return prifix;
  }

  Widget getPriceTextFieldTitle() {
    var title;
    if (widget.ads.adsType == AdsFormState.FOOD.toString().toLowerCase()) {
      title = 'قیمت (به تومان)';
    }
    if (widget.ads.adsType == AdsFormState.JOB.toString().toLowerCase()) {
      title = 'حقوق ماهیانه';
    }
    if (widget.ads.adsType == AdsFormState.REALSTATE.toString().toLowerCase()) {
      title = 'قیمت کل';
    }
    return Text(
      title,
      style: TextStyle(fontSize: Get.width / 28, fontWeight: FontWeight.w400),
      textDirection: TextDirection.rtl,
    );
  }
}
