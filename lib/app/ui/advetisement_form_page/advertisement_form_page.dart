import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
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
import 'package:flutter_image_compress/flutter_image_compress.dart';
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
                      listviewPhoto: await getListviewImage(),
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
    if (advertisementTypeController.formState.value == AdsFormState.Trap) {
      prifix = 'مثال : "فروش 10 راس گوسفند"';
    }
    if (advertisementTypeController.formState.value == AdsFormState.JOB) {
      prifix = 'مثال : "راننده با ماشین"';
    }
    if (advertisementTypeController.formState.value == AdsFormState.REALSTATE) {
      prifix = 'مثال : "زمین کشاورزی"';
    }
    return prifix;
  }

  Future<String> getListviewImage() async {
    String imageForListView = '';
    if (controller.rightImagebyteCode.value.length > 2) {
      imageForListView = controller.rightImagebyteCode.value;
    }
    if (controller.leftImagebyteCode.value.length > 2) {
      imageForListView = controller.leftImagebyteCode.value;
    }
    if (imageForListView.length > 2) {
      imageForListView =
          base64Encode(await comporessList(base64Decode(imageForListView)));
    }
    return imageForListView;
  }

  Future<Uint8List> comporessList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minWidth: 640,
      minHeight: 480,
      quality: 13,
      rotate: 0,
    );

    return result;
  }

  Future<Uint8List> compressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 1334,
      minHeight: 750,
      quality: 40,
      rotate: 0,
    );

    return result!;
  }

//for list view

//  minWidth: 853,
//       minHeight: 480,
//       quality: 27,

//   imageQuality: 100,
//         maxHeight: 480,
//         maxWidth: 853);

  chooseImage() async {
    var uploadImageController = Get.put(UploadImageController());

    var image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxHeight: 750,
        maxWidth: 1334);
    if (image != null) {
      File file = File(image.path);
      String img64 = base64Encode(await compressFile(file));

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
    if (advertisementTypeController.formState.value == AdsFormState.Trap) {
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
