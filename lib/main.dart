import 'package:alamuti/home_page.dart';
import 'package:alamuti/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Application());
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themes,
      home: HomePage(),
    );
  }
}
