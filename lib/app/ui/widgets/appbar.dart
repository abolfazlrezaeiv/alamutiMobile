import 'package:flutter/material.dart';

AppBar appBar(String title) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Color.fromRGBO(8, 212, 76, 0.5),
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(fontSize: 19),
    ),
  );
}
