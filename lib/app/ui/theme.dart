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

var alamutPrimaryColor = Color.fromRGBO(8, 212, 76, 0.5);
var persianNumber = 'IRANSansXFaNum';
