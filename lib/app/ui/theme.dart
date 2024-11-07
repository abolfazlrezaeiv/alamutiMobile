import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var themes = ThemeData(
  fontFamily: 'IRANSansX',
  appBarTheme: AppBarTheme(
    elevation: 9,
    backgroundColor: Color.fromRGBO(78, 198, 122, 1.0),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
        elevation: MaterialStateProperty.all(3),
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

const alamutPrimaryColor = Color.fromRGBO(113, 234, 155, 1.0);
const persianNumber = 'IRANSansXFaNum';

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

//button style
var formSubmitButtonStyle = ButtonStyle(
  elevation: MaterialStateProperty.all(3),
  fixedSize: MaterialStateProperty.all(Size.fromWidth(Get.width / 2.2)),
  backgroundColor: MaterialStateProperty.all(
    Color.fromRGBO(123, 234, 159, 1.0),
  ),
);

getCancelButtonStyle(BuildContext context) => ButtonStyle(
      fixedSize: MaterialStateProperty.all(
          Size.fromWidth(MediaQuery.of(context).size.width / 2.2)),
      backgroundColor: MaterialStateProperty.all(Colors.white),
    );

//text style
var titleStyle =
    TextStyle(fontSize: Get.width / 28, fontWeight: FontWeight.w400);

var formTextButtonStyle = TextStyle(
  color: Color.fromRGBO(88, 77, 77, 1.0),
  fontWeight: FontWeight.w400,
  fontSize: Get.width / 25,
);

var secondTile =
    TextStyle(fontSize: Get.width / 31, fontWeight: FontWeight.w300);

//PADINGS
var formFieldPadding = EdgeInsets.symmetric(horizontal: Get.width / 35);
var formTitlePadding = EdgeInsets.symmetric(horizontal: Get.width / 25);
