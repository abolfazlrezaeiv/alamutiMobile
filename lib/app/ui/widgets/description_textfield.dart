import 'package:flutter/material.dart';

class DescriptionTextField extends StatelessWidget {
  String? initialvalue = ' ';

  DescriptionTextField(
      {Key? key, required this.textEditingController, this.initialvalue})
      : super(key: key);
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      textDirection: TextDirection.rtl,
      keyboardType: TextInputType.multiline,
      maxLines: 6,
      style: TextStyle(backgroundColor: Colors.white),
      decoration: InputDecoration(
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
