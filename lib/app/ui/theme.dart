import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

var themes = ThemeData(
  fontFamily: 'IRANSansX',
  appBarTheme: AppBarTheme(
    backgroundColor: Color.fromRGBO(8, 212, 76, 0.5),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Color.fromRGBO(8, 212, 76, 0.5),
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
