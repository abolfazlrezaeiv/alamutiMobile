import 'dart:convert';
import 'package:alamuti/app/controller/ads_form_controller.dart';
import 'package:alamuti/app/controller/upload_image_controller.dart';
import 'package:alamuti/app/data/provider/advertisement_provider.dart';
import 'package:alamuti/app/ui/advertisement_form_page/form_functions.dart';
import 'package:alamuti/app/ui/theme.dart';
import 'package:alamuti/app/ui/widgets/add_ads_photo_card.dart';
import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:alamuti/app/ui/widgets/alamuti_textfield.dart';
import 'package:alamuti/app/ui/widgets/description_textfield.dart';
import 'package:alamuti/app/ui/widgets/photo_card_left.dart';
import 'package:alamuti/app/ui/widgets/photo_card_right.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdvertisementForm extends StatefulWidget {
  @override
  State<AdvertisementForm> createState() => _AdvertisementFormState();
}

class _AdvertisementFormState extends State<AdvertisementForm> {
  UploadImageController uploadImageController = Get.find();
  AdvertisementTypeController advertisementTypeController = Get.find();
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
                          onTap: () =>
                              FormFunction.chooseImage(uploadImageController),
                          child: AddPhotoWidget()),
                    ],
                  ),
                ],
              ),
              SizedBox(height: Get.height / 45),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: formTitlePadding,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'عنوان آگهی',
                          style: titleStyle,
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(height: Get.height / 65),
                        Text(
                          'در عنوان آگهی به موارد مهم و چشمگیر اشاره کنید',
                          style: secondTile,
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height / 80),
                  Padding(
                    padding: formFieldPadding,
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
                    padding: formTitlePadding,
                    child: FormFunction.getPriceTextFieldTitle(isUpdate: false),
                  ),
                  SizedBox(height: Get.height / 80),
                  Padding(
                    padding: formFieldPadding,
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
                    padding: formTitlePadding,
                    child: Text(
                      'نام روستا',
                      style: titleStyle,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  SizedBox(height: Get.height / 80),
                  Padding(
                    padding: formFieldPadding,
                    child: Container(
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              // showCategoryDialog(context: context);
                            },
                            child: Text('انتخاب'),
                          ),
                          Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: Get.height / 20),
                  Padding(
                    padding: formTitlePadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'توضیحات آگهی',
                          style: titleStyle,
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(height: Get.height / 65),
                        Text(
                          'جزئیات و نکات قابل توجه آگهی خود را کامل و دقیق بنویسید',
                          style: secondTile,
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height / 80),
                  Padding(
                    padding: formFieldPadding,
                    child: DescriptionTextField(
                      minLine: 5,
                      maxLine: 8,
                      textEditingController: descriptionTextFieldController,
                    ),
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
                  style: formSubmitButtonStyle,
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
                        adsType: advertisementTypeController.formState.value
                            .toString()
                            .toLowerCase(),
                      );
                    }
                    uploadImageController.leftImagebyteCode.value = '';
                    uploadImageController.rightImagebyteCode.value = '';
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'ثبت',
                      style: formTextButtonStyle,
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
      imageForListView = base64Encode(
          await FormFunction.compressList(base64Decode(imageForListView)));
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
