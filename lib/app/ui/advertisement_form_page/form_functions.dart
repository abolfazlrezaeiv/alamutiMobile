import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:alamuti/app/controller/ads_form_controller.dart';
import 'package:alamuti/app/ui/widgets/alamuti_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FormFunction{

  static String titleTextfieldPrefix() {
    var advertisementTypeController = Get.put(AdvertisementTypeController());
    var prefix;
    switch (advertisementTypeController.formState.value) {
      case AdsFormState.FOOD:
        prefix = 'مثال : "گیلاس آتان"';
        break;
      case AdsFormState.Trap:
        prefix = 'مثال : "فروش 10 راس گوسفند"';
        break;
      case AdsFormState.JOB:
        prefix = 'مثال : "راننده با ماشین"';
        break;
      case AdsFormState.REALSTATE:
        prefix = 'مثال : "زمین کشاورزی"';
        break;
    }
    return prefix;
  }


  static Widget getAreaTextField(TextEditingController areaTextFieldController) {
    var advertisementTypeController = Get.put(AdvertisementTypeController());

    return advertisementTypeController.formState.value.toString() ==
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

  static Widget getPriceTextFieldTitle({String adsType ='',required bool isUpdate }) {
    var title;
    if(isUpdate){
      if (adsType == AdsFormState.FOOD.toString().toLowerCase()) {
        title = 'قیمت (به تومان)';
      }
      if (adsType == AdsFormState.FOOD.toString().toLowerCase()) {
        title = 'قیمت (به تومان)';
      }
      if (adsType == AdsFormState.JOB.toString().toLowerCase()) {
        title = 'دستمزد';
      }
      if (adsType == AdsFormState.REALSTATE.toString().toLowerCase()) {
        title = 'قیمت کل';
      }
      return Text(
        title,
        style: TextStyle(fontSize: Get.width / 28, fontWeight: FontWeight.w400),
        textDirection: TextDirection.rtl,
      );
    }else{
      var advertisementTypeController = Get.put(AdvertisementTypeController());
      switch (advertisementTypeController.formState.value) {
        case AdsFormState.FOOD:
          title = 'قیمت';
          break;
        case AdsFormState.Trap:
          title = 'قیمت';
          break;
        case AdsFormState.JOB:
          title = 'دستمزد';
          break;
        case AdsFormState.REALSTATE:
          title = 'قیمت کل';
          break;
      }
      return Text(
        title,
        style: TextStyle(fontSize: Get.width / 28, fontWeight: FontWeight.w400),
        textDirection: TextDirection.rtl,
      );
    }
  }

  static Future<Uint8List> compressList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minWidth: 640,
      minHeight: 480,
      quality: 13,
      rotate: 0,
    );

    return result;
  }

  static  Future<Uint8List> compressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 1334,
      minHeight: 750,
      quality: 40,
      rotate: 0,
    );
    return result!;
  }

  static chooseImage(controller) async {
    XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxHeight: 750,
        maxWidth: 1334);
    if (image != null) {
      File file = File(image.path);
      String img64 = base64Encode(await FormFunction.compressFile(file));

      controller.getImage(img64);
    } else {
      print('picked image is null');
    }
  }

}





