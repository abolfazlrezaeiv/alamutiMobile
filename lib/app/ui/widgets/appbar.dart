import 'package:alamuti/app/ui/theme.dart';
import 'package:flutter/material.dart';

AppBar appBar(String title) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: alamutPrimaryColor,
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(fontSize: 19),
    ),
  );
}
