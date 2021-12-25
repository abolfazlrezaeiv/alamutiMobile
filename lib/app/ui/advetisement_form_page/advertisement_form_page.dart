import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:alamuti/app/controller/adsFormController.dart';
import 'package:alamuti/app/controller/selectedTapController.dart';
import 'package:alamuti/app/controller/upload_image_controller.dart';
import 'package:alamuti/app/data/provider/advertisement_provider.dart';
import 'package:alamuti/app/ui/home/home_page.dart';
import 'package:alamuti/app/ui/imgaebase64.dart';
import 'package:alamuti/app/ui/post_ads_category/submit_ads_category.dart';
import 'package:alamuti/app/ui/widgets/photo_card_left.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/add_ads_photo_card.dart';
import '../widgets/alamuti_appbar.dart';
import '../widgets/alamuti_textfield.dart';
import '../widgets/description_textfield.dart';
import '../widgets/photo_card_right.dart';

class AdvertisementForm extends StatefulWidget {
  @override
  State<AdvertisementForm> createState() => _AdvertisementFormState();
}

class _AdvertisementFormState extends State<AdvertisementForm> {
  AdsFormController adsFormController = Get.put(AdsFormController());
  ScreenController screenController = Get.put(ScreenController());
  UploadImageController uploadImageController =
      Get.put(UploadImageController());
  final GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController priceTextFieldController = TextEditingController();

  TextEditingController titleTextFieldController = TextEditingController();

  TextEditingController areaTextFieldController = TextEditingController();

  TextEditingController descriptionTextFieldController =
      TextEditingController();

  AdvertisementProvider advertisementProvider = AdvertisementProvider();

  Uint8List? logoBase64;
  var pickedFile;

  var _image;

  String? _image64;

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
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 40),
        child: Form(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width / 40.0,
                        bottom: 3),
                    child: Text(
                      'عنوان آگهی',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  AlamutiTextField(
                    textEditingController: titleTextFieldController,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  getPriceTextFieldTitle(),
                  AlamutiTextField(
                    textEditingController: priceTextFieldController,
                  ),
                ],
              ),
              getAreaTextField(),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width / 40.0,
                  bottom: 3,
                ),
                child: Text(
                  'توضیحات',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  textDirection: TextDirection.rtl,
                ),
              ),
              DescriptionTextField(
                  textEditingController: descriptionTextFieldController),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width / 40.0,
                    bottom: MediaQuery.of(context).size.height / 20.0),
                child: TextButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(10, 210, 71, 0.5),
                  ),
                  onPressed: () async {
                    var response =
                        await advertisementProvider.postAdvertisement(
                      area: areaTextFieldController.text.isEmpty
                          ? 0
                          : int.parse(areaTextFieldController.text),
                      description: descriptionTextFieldController.text,
                      photo1: uploadImageController.leftImagebyteCode.value,
                      photo2: uploadImageController.rightImagebyteCode.value,
                      price: int.parse(priceTextFieldController.text),
                      title: titleTextFieldController.text,
                    );
                    screenController.selectedIndex = 4;

                    Get.toNamed('/home');
                  },
                  child: Text(
                    'ثبت',
                    style: TextStyle(color: Colors.grey[700], fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getAreaTextField() {
    return adsFormController.formState == AdsFormState.REALSTATE
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width / 40.0, bottom: 3),
                child: Text(
                  "متراژ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  textDirection: TextDirection.rtl,
                ),
              ),
              AlamutiTextField(textEditingController: areaTextFieldController),
            ],
          )
        : Container();
  }

  chooseImage() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      print('its not null');
      if (image != null) {
        setState(() {
          _image = File(image.path);
        });

        final bytes = File(image.path).readAsBytesSync();

        String img64 = base64Encode(bytes);
        setState(() {
          _image64 = img64;
        });
        uploadImageController.getImage(img64);
      }
    } else {
      print('picked image is null');
    }
  }

  Widget getPriceTextFieldTitle() {
    var title;
    if (adsFormController.formState == AdsFormState.FOOD) {
      title = 'قیمت (به تومان)';
    }
    if (adsFormController.formState == AdsFormState.JOB) {
      title = 'حقوق ماهیانه';
    }
    if (adsFormController.formState == AdsFormState.REALSTATE) {
      title = 'قیمت کل';
    }
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.width / 35.0, bottom: 3),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
