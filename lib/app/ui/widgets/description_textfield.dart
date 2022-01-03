import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DescriptionTextField extends StatelessWidget {
  String? initialvalue = ' ';

  final TextEditingController textEditingController;

  DescriptionTextField(
      {Key? key, required this.textEditingController, this.initialvalue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      textDirection: TextDirection.rtl,
      keyboardType: TextInputType.multiline,
      maxLines: 6,
      textAlign: TextAlign.start,
      style: TextStyle(
          backgroundColor: Colors.white,
          fontSize: Get.width / 27,
          fontWeight: FontWeight.w300),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(8),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 0.6),
        ),
      ),
    );
  }
}
