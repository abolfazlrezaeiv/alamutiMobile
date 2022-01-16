import 'package:alamuti/app/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DescriptionTextField extends StatelessWidget {
  String? initialvalue = ' ';

  final TextEditingController textEditingController;

  final double width = Get.width;

  final double height = Get.height;

  DescriptionTextField(
      {Key? key, required this.textEditingController, this.initialvalue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        textInputAction: TextInputAction.newline,
        controller: textEditingController,
        textDirection: TextDirection.rtl,
        keyboardType: TextInputType.multiline,
        validator: (value) {
          if (value == null || value.isEmpty || value.length < 0) {
            return 'این مورد را کامل کنید';
          }

          if (textEditingController.text.length > 330) {
            var aditionalCahracter = textEditingController.text.length - 330;
            return 'طول متن $aditionalCahracter حرف بیشتر از حد مجاز';
          }

          return null;
        },
        maxLines: 6,
        textAlign: TextAlign.start,
        style: TextStyle(
            backgroundColor: Colors.white,
            fontSize: width / 27,
            fontFamily: persianNumber,
            fontWeight: FontWeight.w300),
        decoration: InputDecoration(
          errorStyle: const TextStyle(fontSize: 13),
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
            borderSide: BorderSide(
                color: Color.fromRGBO(112, 112, 112, 0.2), width: 2.0),
          ),
        ),
      ),
    );
  }
}
