import 'package:alamuti/app/controller/price_with_symbol.dart';
import 'package:alamuti/app/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlamutiTextField extends StatelessWidget {
  final TextEditingController textEditingController;

  final bool hasCharacterLimitation;

  final bool isNumber;

  final bool isChatTextField;

  final bool isPrice;

  final String prefix;

  final PriceController priceController = Get.put(PriceController());

  AlamutiTextField(
      {Key? key,
      required this.textEditingController,
      required this.isNumber,
      required this.hasCharacterLimitation,
      required this.isChatTextField,
      required this.isPrice,
      required this.prefix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          textInputAction:
              isChatTextField ? TextInputAction.newline : TextInputAction.done,
          onFieldSubmitted: (value) {
            FocusScope.of(context).unfocus();
          },
          controller: textEditingController,
          keyboardType:
              isNumber ? TextInputType.number : TextInputType.multiline,
          textAlign: TextAlign.start,
          style: TextStyle(
              backgroundColor: Colors.transparent,
              fontSize: Get.width / 27,
              fontFamily: persianNumber,
              fontWeight: FontWeight.w300),
          decoration: InputDecoration(
            label: Text(
              prefix,
              style: TextStyle(
                  backgroundColor: Colors.white.withOpacity(0.5),
                  fontSize: Get.width / 30,
                  fontFamily: persianNumber,
                  fontWeight: FontWeight.w300),
            ),
            errorStyle: isChatTextField
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
}
