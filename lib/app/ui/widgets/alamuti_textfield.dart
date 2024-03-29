import 'package:alamuti/app/controller/price_with_symbol.dart';
import 'package:alamuti/app/controller/text_focus_controller.dart';
import 'package:alamuti/app/ui/constants.dart';
import 'package:alamuti/app/ui/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlamutiTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final bool hasCharacterLimitation;
  final bool isNumber;
  final bool isChatTextField;
  final bool isPrice;
  final String prefix;
  bool isVillageField = false;

  AlamutiTextField(
      {Key? key,
      required this.textEditingController,
      required this.isNumber,
      required this.hasCharacterLimitation,
      required this.isChatTextField,
      required this.isPrice,
      required this.prefix,
      this.isVillageField = false})
      : super(key: key);

  @override
  State<AlamutiTextField> createState() => _AlamutiTextFieldState();
}

class _AlamutiTextFieldState extends State<AlamutiTextField> {
  final PriceController priceController = Get.put(PriceController());
  final TextFocusController textFocusController =
      Get.put(TextFocusController());
  var _focus = FocusNode();
  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    textFocusController.isFocused.value = _focus.hasFocus;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          focusNode: _focus,
          textInputAction: widget.isChatTextField
              ? TextInputAction.newline
              : TextInputAction.done,
          onFieldSubmitted: (value) {
            FocusScope.of(context).unfocus();
          },
          controller: widget.textEditingController,
          onChanged: (text) {
            if (widget.isPrice) {
              priceController.price.value = text;
              widget.textEditingController.text = getPersianPriceHint(text);
              widget.textEditingController.value =
                  widget.textEditingController.value.copyWith(
                selection: TextSelection(
                    baseOffset: getPersianPriceHint(text).length,
                    extentOffset: getPersianPriceHint(text).length),
                composing: TextRange.empty,
              );
            }
          },
          minLines: 1,
          maxLines: widget.isChatTextField ? 4 : 1,
          validator: (value) {
            if (value == null || value.isEmpty || value.length < 0) {
              return 'این مورد را کامل کنید';
            }

            if (widget.hasCharacterLimitation) {
              if (widget.textEditingController.text.length > 27) {
                var additionalCharacter =
                    widget.textEditingController.text.length - 27;
                return 'طول متن $additionalCharacter حرف بیشتر از حد مجاز';
              }
            }

            return null;
          },
          textDirection: TextDirection.rtl,
          keyboardType:
              widget.isNumber ? TextInputType.number : TextInputType.multiline,
          textAlign: TextAlign.start,
          style: TextStyle(
              backgroundColor: Colors.transparent,
              fontSize: Get.width / 27,
              fontFamily: persianNumber,
              fontWeight: FontWeight.w300),
          decoration: InputDecoration(
            suffixIcon: widget.isVillageField
                ? TextButton(
                    onPressed: () {
                      showItemListDialog(context: context, list: villages);
                    },
                    child:
                        Text('انتخاب', style: TextStyle(color: Colors.green)),
                  )
                : IconButton(
                    icon: Obx(() => Icon(
                          CupertinoIcons.multiply_circle_fill,
                          textDirection: TextDirection.ltr,
                          color: textFocusController.isFocused.value == true
                              ? Colors.grey
                              : Colors.transparent,
                        )),
                    onPressed: () {
                      widget.textEditingController.text = '';
                    },
                  ),
            label: Text(
              widget.prefix,
              style: TextStyle(
                  backgroundColor: Colors.white.withOpacity(0.5),
                  fontSize: Get.width / 30,
                  fontFamily: persianNumber,
                  fontWeight: FontWeight.w300),
            ),
            errorStyle: widget.isChatTextField
                ? TextStyle(height: 0, fontSize: 0, fontFamily: persianNumber)
                : TextStyle(fontSize: 13, fontFamily: persianNumber),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 0.6),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.red,
                width: 0.6,
                style: BorderStyle.solid,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: Color.fromRGBO(112, 112, 112, 0.2), width: 2.0),
            ),
          ),
        ),
      ),
    );
  }

  showItemListDialog({required context, list}) {
    AlertDialog alert = AlertDialog(
        backgroundColor: Colors.white,
        elevation: 3,
        content: Container(
          height: 400,
          width: 30,
          child: ListView.builder(
            physics: ClampingScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  widget.textEditingController.text = list[index];
                  Get.back();
                },
                child: ListTile(
                  title: Text(
                    list[index],
                    textDirection: TextDirection.rtl,
                  ),
                ),
              );
            },
          ),
        ));
    showDialog(
      barrierDismissible: true,
      builder: (BuildContext context) => alert,
      context: context,
    );
  }

  String getPersianPriceHint(String text) {
    var commaAddedPrice = priceController.price.value
        .split('')
        .reversed
        .join()
        .replaceAll(',', '')
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

    return result;
  }
}
