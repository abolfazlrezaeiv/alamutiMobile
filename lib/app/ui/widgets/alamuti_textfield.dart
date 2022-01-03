import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlamutiTextField extends StatelessWidget {
  final TextEditingController textEditingController;

  final bool isNumber;
  AlamutiTextField({
    Key? key,
    required this.textEditingController,
    required this.isNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 15,
      child: TextFormField(
        controller: textEditingController,
        validator: (value) {
          if (value == null || value.isEmpty || value.length < 0) {
            return 'خالی است  ';
          }
          return null;
        },
        textDirection: TextDirection.rtl,
        keyboardType: isNumber ? TextInputType.number : TextInputType.name,
        textAlign: TextAlign.start,
        style: TextStyle(
            backgroundColor: Colors.white,
            fontSize: Get.width / 27,
            fontFamily: 'IRANSansXFaNum',
            fontWeight: FontWeight.w300),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(
            8, // HERE THE IMPORTANT PART
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 0.6),
          ),
        ),
      ),
    );
  }
}
