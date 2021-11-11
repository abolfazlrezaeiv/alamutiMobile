import 'package:flutter/material.dart';

class DescriptionTextField extends StatelessWidget {
  const DescriptionTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 8),
          child: Text(
            'توضیحات',
            style: TextStyle(fontSize: 16),
            textDirection: TextDirection.rtl,
          ),
        ),
        TextFormField(
          textDirection: TextDirection.rtl,
          keyboardType: TextInputType.multiline,
          maxLines: 6,
          style: TextStyle(backgroundColor: Colors.white),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.black38.withOpacity(0.1), width: 2.0),
            ),
          ),
        )
      ],
    );
  }
}
