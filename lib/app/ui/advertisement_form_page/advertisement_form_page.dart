import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:alamuti/app/controller/upload_image_controller.dart';
import 'package:alamuti/app/data/provider/advertisement_provider.dart';
import 'package:alamuti/app/ui/advertisement_form_page/form_functions.dart';
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

class AdvertisementForm extends StatefulWidget {
  @override
  State<AdvertisementForm> createState() => _AdvertisementFormState();
}

class _AdvertisementFormState extends State<AdvertisementForm> {
  UploadImageController uploadImageController = Get.find();

  final areaTextFieldController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController priceTextFieldController =
      TextEditingController();

  final TextEditingController titleTextFieldController =
      TextEditingController();

  final TextEditingController villageNameTextFieldController =
      TextEditingController();

  final TextEditingController descriptionTextFieldController =
      TextEditingController();

  final AdvertisementProvider advertisementProvider = AdvertisementProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AlamutiAppBar(
        title: 'ثبت آگهی',
        hasBackButton: true,
        appBar: AppBar(),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(height: Get.height / 45),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      LeftPhotoCard(),
                      RightPhotoCard(),
                      GestureDetector(
                          onTap: () => FormFunction.chooseImage(uploadImageController), child: AddPhotoWidget()),
                    ],
                  ),
                ],
              ),
              SizedBox(height: Get.height / 45),
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
                      prefix: FormFunction.titleTextfieldPrefix(),
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
                    child: FormFunction.getPriceTextFieldTitle(isUpdate: false),
                  ),
                  SizedBox(height: Get.height / 80),
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
              FormFunction.getAreaTextField(areaTextFieldController),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: Get.height / 40),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
                    child: Text(
                      'نام روستا',
                      style: TextStyle(
                          fontSize: Get.width / 28,
                          fontWeight: FontWeight.w400),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  SizedBox(height: Get.height / 80),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width / 35),
                    child: AlamutiTextField(
                      textEditingController: villageNameTextFieldController,
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
                  SizedBox(height: Get.height / 20),
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
                        minline: 5,
                        maxline: 8,
                        textEditingController: descriptionTextFieldController),
                  ),
                ],
              ),
              SizedBox(height: Get.height / 80),
              Container(
                padding: EdgeInsets.only(
                    right: Get.width / 2,
                    left: Get.width / 35,
                    bottom: Get.width / 35),
                child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(3),
                      fixedSize: MaterialStateProperty.all(
                          Size.fromWidth(Get.width / 2.2)),
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(123, 234, 159, 1.0),
                      )),
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState!.validate()) {
                      await advertisementProvider.postAdvertisement(
                        context: context,
                        area: areaTextFieldController.text.isEmpty
                            ? 0
                            : int.parse(areaTextFieldController.text),
                        village: villageNameTextFieldController.text,
                        description: descriptionTextFieldController.text,
                        photo1: uploadImageController.leftImagebyteCode.value,
                        photo2: uploadImageController.rightImagebyteCode.value,
                        listviewPhoto: await getListviewImage(),
                        price: int.parse(
                            priceTextFieldController.text.replaceAll(',', '')),
                        title: titleTextFieldController.text,
                      );
                    }
                    uploadImageController.leftImagebyteCode.value = '';
                    uploadImageController.rightImagebyteCode.value = '';
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'ثبت',
                      style: TextStyle(
                        color: Color.fromRGBO(88, 77, 77, 1.0),
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

  Future<String> getListviewImage() async {
    String imageForListView = '';
    if (uploadImageController.rightImagebyteCode.value.length > 2) {
      imageForListView = uploadImageController.rightImagebyteCode.value;
    }
    if (uploadImageController.leftImagebyteCode.value.length > 2) {
      imageForListView = uploadImageController.leftImagebyteCode.value;
    }
    if (imageForListView.length > 2) {
      imageForListView =
          base64Encode(await FormFunction.compressList(base64Decode(imageForListView)));
    }
    return imageForListView;
  }


  @override
  void dispose() {
    areaTextFieldController.dispose();
    priceTextFieldController.dispose();
    titleTextFieldController.dispose();
    villageNameTextFieldController.dispose();
    descriptionTextFieldController.dispose();
    super.dispose();
  }
}
