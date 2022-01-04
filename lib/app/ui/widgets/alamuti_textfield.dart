import 'package:alamuti/app/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlamutiTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool hasCharacterLimitation;
  final bool isNumber;
  late bool isChatTextField;
  AlamutiTextField(
      {Key? key,
      required this.textEditingController,
      required this.isNumber,
      required this.hasCharacterLimitation,
      required this.isChatTextField})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: Get.height / 15,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          onFieldSubmitted: (value) {
            FocusScope.of(context).unfocus();
          },
          controller: textEditingController,
          validator: (value) {
            if (value == null || value.isEmpty || value.length < 0) {
              return 'این مورد را کامل کنید';
            }

            if (hasCharacterLimitation) {
              if (textEditingController.text.length > 27) {
                var aditionalCahracter = textEditingController.text.length - 27;
                return 'طول متن $aditionalCahracter حرف بیشتر از حد مجاز';
              }
            }

            return null;
          },
          textDirection: TextDirection.rtl,
          keyboardType: isNumber ? TextInputType.number : TextInputType.name,
          textAlign: TextAlign.start,
          style: TextStyle(
              backgroundColor: Colors.white,
              fontSize: Get.width / 27,
              fontFamily: persianNumber,
              fontWeight: FontWeight.w300),
          decoration: InputDecoration(
            errorStyle: isChatTextField
                ? TextStyle(height: 0, fontSize: 0, fontFamily: persianNumber)
                : TextStyle(fontSize: 13, fontFamily: persianNumber),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 0.6),
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
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.black, width: 0.6),
            ),
          ),
        ),
      ),
    );
  }
}
