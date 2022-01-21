import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:alamuti/app/controller/ads_form_controller.dart';
import 'package:alamuti/app/controller/selected_tap_controller.dart';
import 'package:alamuti/app/controller/update_image_advertisement_controller.dart';
import 'package:alamuti/app/data/entities/advertisement.dart';
import 'package:alamuti/app/data/provider/advertisement_provider.dart';
import 'package:alamuti/app/ui/widgets/add_ads_photo_card.dart';
import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:alamuti/app/ui/widgets/alamuti_textfield.dart';
import 'package:alamuti/app/ui/widgets/description_textfield.dart';
import 'package:alamuti/app/ui/widgets/update_image_card_left.dart';
import 'package:alamuti/app/ui/widgets/update_image_card_right.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
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

  final UpdateUploadImageController updateUploadImageController = Get.find();

  final AdvertisementProvider advertisementProvider = AdvertisementProvider();

  late TextEditingController titleTextFieldController;

  late TextEditingController priceTextFieldController;

  late TextEditingController vilageNameTextFieldController;

  late TextEditingController areaTextFieldController;

  late TextEditingController descriptionTextFieldController;

  final double width = Get.width;

  final double height = Get.height;

  @override
  initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      updateUploadImageController.leftImagebyteCode.value =
          widget.ads.photo1 ?? '';

      updateUploadImageController.rightImagebyteCode.value =
          widget.ads.photo2 ?? '';
    });

    titleTextFieldController = TextEditingController(text: widget.ads.title);
    priceTextFieldController =
        TextEditingController(text: widget.ads.price.toString());

    areaTextFieldController = TextEditingController(text: widget.ads.area);
    vilageNameTextFieldController =
        TextEditingController(text: widget.ads.village);
    descriptionTextFieldController =
        TextEditingController(text: widget.ads.description);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AlamutiAppBar(
        title: 'ویرایش آگهی',
        hasBackButton: true,
        appBar: AppBar(),
        backwidget: "/myads",
      ),
      body: WillPopScope(
        onWillPop: () async {
          Get.put(ScreenController()).selectedIndex.value = 0;
          Get.back();
          return false;
        },
        child: Form(
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
                              fontSize: width / 28,
                              fontWeight: FontWeight.w400),
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(height: height / 65),
                        Text(
                          'در عنوان آگهی به موارد مهم و چشمگیر اشاره کنید',
                          style: TextStyle(
                              fontSize: width / 31,
                              fontWeight: FontWeight.w300),
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
                              fontSize: width / 28,
                              fontWeight: FontWeight.w400),
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(height: height / 65),
                        Text(
                          'جزئیات و نکات قابل توجه آگهی خود را کامل و دقیق بنویسید',
                          style: TextStyle(
                              fontSize: width / 31,
                              fontWeight: FontWeight.w300),
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
                      await advertisementProvider.updateAdvertisement(
                        context: context,
                        area: areaTextFieldController.text.isEmpty
                            ? 0
                            : int.parse(areaTextFieldController.text),
                        description: descriptionTextFieldController.text,
                        photo1:
                            updateUploadImageController.leftImagebyteCode.value,
                        photo2: updateUploadImageController
                            .rightImagebyteCode.value,
                        listviewPhoto: await _getListviewImage(),
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
                      fontSize: width / 25,
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

  Widget getAreaTextField() {
    return widget.ads.adsType == AdsFormState.REALSTATE.toString().toLowerCase()
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

  Future<String> _getListviewImage() async {
    String imageForListView = '';
    if (updateUploadImageController.rightImagebyteCode.value.length > 2) {
      imageForListView = updateUploadImageController.rightImagebyteCode.value;
    }
    if (updateUploadImageController.leftImagebyteCode.value.length > 2) {
      imageForListView = updateUploadImageController.leftImagebyteCode.value;
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
      minWidth: 640,
      minHeight: 480,
      quality: 13,
      rotate: 0,
    );
    return result;
  }

  Future<Uint8List> _compressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 1334,
      minHeight: 750,
      quality: 40,
      rotate: 0,
    );

    return result!;
  }

  chooseImage() async {
    UpdateUploadImageController updateUploadImageController =
        Get.put(UpdateUploadImageController());

    XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxHeight: 750,
        maxWidth: 1334);
    if (image != null) {
      // final bytes = File(image.path).readAsBytesSync();
      File file = File(image.path);
      String img64 = base64Encode(await _compressFile(file));

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
      style: TextStyle(fontSize: width / 28, fontWeight: FontWeight.w400),
      textDirection: TextDirection.rtl,
    );
  }
}
