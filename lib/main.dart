import 'package:alamuti/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Application());
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'IRANSansX',
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color.fromRGBO(8, 212, 76, 0.5),
          unselectedIconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: HomePage(),
    );
  }
}
