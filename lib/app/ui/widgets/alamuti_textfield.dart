import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlamutiTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  AlamutiTextField({
    Key? key,
    required this.textEditingController,
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
        style: TextStyle(backgroundColor: Colors.white),
        decoration: InputDecoration(
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
