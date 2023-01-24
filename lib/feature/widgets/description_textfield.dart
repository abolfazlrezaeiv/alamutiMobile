import 'dart:math' as math;

import 'package:alamuti/feature/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DescriptionTextField extends StatelessWidget {
  String? initialvalue = ' ';
  final int maxline;
  final int minline;
  final TextEditingController textEditingController;

  DescriptionTextField(
      {Key? key,
      required this.textEditingController,
      this.initialvalue,
      required this.maxline,
      required this.minline})
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

          if (textEditingController.text.length > 600) {
            var aditionalCahracter = textEditingController.text.length - 600;
            return 'طول متن $aditionalCahracter حرف بیشتر از حد مجاز';
          }

          return null;
        },
        inputFormatters: [MaxLinesTextInputFormatter(maxline)],
        // expands: true,
        maxLines: null,
        minLines: minline,
        textAlign: TextAlign.start,
        style: TextStyle(
            backgroundColor: Colors.white,
            fontSize: Get.width / 27,
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

class MaxLinesTextInputFormatter extends TextInputFormatter {
  MaxLinesTextInputFormatter(this.maxLines)
      : assert(maxLines == -1 || maxLines > 0);

  final int maxLines;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    if (maxLines > 0) {
      final regEx = RegExp("^.*((\n?.*){0,${maxLines - 1}})");
      String newString = regEx.stringMatch(newValue.text) ?? "";

      final maxLength = newString.length;
      if (newValue.text.runes.length > maxLength) {
        final TextSelection newSelection = newValue.selection.copyWith(
          baseOffset: math.min(newValue.selection.start, maxLength),
          extentOffset: math.min(newValue.selection.end, maxLength),
        );
        final RuneIterator iterator = RuneIterator(newValue.text);
        if (iterator.moveNext())
          for (int count = 0; count < maxLength; ++count)
            if (!iterator.moveNext()) break;
        final String truncated = newValue.text.substring(0, iterator.rawIndex);
        return TextEditingValue(
          text: truncated,
          selection: newSelection,
          composing: TextRange.empty,
        );
      }
      return newValue;
    }
    return newValue;
  }
}
