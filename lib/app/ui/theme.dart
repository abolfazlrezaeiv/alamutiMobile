import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

var themes = ThemeData(
  fontFamily: 'IRANSansX',
  appBarTheme: AppBarTheme(
    elevation: 6,
    backgroundColor: Color.fromRGBO(78, 198, 122, 1.0),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
        elevation: MaterialStateProperty.all(3),
        fixedSize: MaterialStateProperty.all(Size.fromWidth(Get.width / 2.2)),
        backgroundColor: MaterialStateProperty.all(
          Color.fromRGBO(123, 234, 159, 1.0),
        )),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.greenAccent),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color.fromRGBO(113, 234, 155, 1.0),
      unselectedIconTheme: IconThemeData(color: Colors.black),
      selectedIconTheme: IconThemeData(color: Colors.white.withOpacity(0.9)),
      selectedItemColor: Colors.white.withOpacity(0.9)),
);

const styleSomebody = BubbleStyle(
  nip: BubbleNip.leftCenter,
  color: Colors.white,
  borderWidth: 1,
  elevation: 4,
  margin: BubbleEdges.only(top: 8, right: 50),
  alignment: Alignment.topLeft,
);

const styleMe = BubbleStyle(
  nip: BubbleNip.rightCenter,
  color: Color.fromARGB(255, 225, 255, 199),
  borderWidth: 1,
  elevation: 4,
  margin: BubbleEdges.only(top: 8, left: 50),
  alignment: Alignment.topRight,
);

var alamutPrimaryColor = Color.fromRGBO(8, 212, 76, 0.5);
var persianNumber = 'IRANSansXFaNum';

InputDecoration inputDecoration(String labelText, IconData iconData,
    {String? prefix, String? helperText}) {
  return InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
    helperText: helperText,
    labelText: labelText,
    labelStyle: TextStyle(
      color: Colors.grey,
    ),
    prefixText: prefix,
    prefixIcon: Icon(
      iconData,
      size: 20,
    ),
    counterText: '',
    prefixIconConstraints: BoxConstraints(minWidth: 60),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:
            BorderSide(color: Color.fromRGBO(69, 230, 123, 1), width: 0.9)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:
            BorderSide(color: Color.fromRGBO(69, 230, 123, 1), width: 2)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red)),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.white)),
  );
}
