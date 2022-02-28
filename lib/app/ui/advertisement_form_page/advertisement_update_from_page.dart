import 'dart:convert';
import 'package:alamuti/app/controller/selected_tap_controller.dart';
import 'package:alamuti/app/controller/update_image_advertisement_controller.dart';
import 'package:alamuti/app/data/entities/advertisement.dart';
import 'package:alamuti/app/data/provider/advertisement_provider.dart';
import 'package:alamuti/app/ui/advertisement_form_page/form_functions.dart';
import 'package:alamuti/app/ui/theme.dart';
import 'package:alamuti/app/ui/widgets/add_ads_photo_card.dart';
import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:alamuti/app/ui/widgets/alamuti_textfield.dart';
import 'package:alamuti/app/ui/widgets/description_textfield.dart';
import 'package:alamuti/app/ui/widgets/update_image_card_left.dart';
import 'package:alamuti/app/ui/widgets/update_image_card_right.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  late TextEditingController villageNameTextFieldController;

  late TextEditingController areaTextFieldController;

  late TextEditingController descriptionTextFieldController;

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
    villageNameTextFieldController =
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
      ),
      body: WillPopScope(
        onWillPop: () async {
          Get.put(ScreenController()).selectedIndex.value = 0;
          Get.back();
          return false;
        },
        child: GestureDetector(
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
                        UpdateLeftPhotoCard(),
                        UpdateRightPhotoCard(),
                        GestureDetector(
                            onTap: () => FormFunction.chooseImage(
                                updateUploadImageController),
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
                      child: FormFunction.getPriceTextFieldTitle(
                          adsType: widget.ads.adsType, isUpdate: true),
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
                          textEditingController:
                              descriptionTextFieldController),
                    ),
                  ],
                ),
                SizedBox(height: Get.height / 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                          Size.fromWidth(
                              MediaQuery.of(context).size.width / 2.2),
                        ),
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
                            photo1: updateUploadImageController
                                .leftImagebyteCode.value,
                            photo2: updateUploadImageController
                                .rightImagebyteCode.value,
                            listviewPhoto: await _getListviewImage(),
                            price: int.parse(priceTextFieldController.text
                                .replaceAll(RegExp(r','), '')),
                            village: villageNameTextFieldController.text,
                            title: titleTextFieldController.text,
                            id: widget.ads.id,
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'ذخیره',
                          style: formTextButtonStyle,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      style: getCancelButtonStyle(context),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'انصراف',
                          style: formTextButtonStyle,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
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
