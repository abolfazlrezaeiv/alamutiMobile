import 'dart:convert';

import 'package:alamuti/app/ui/details/detail_page.dart';
import 'package:alamuti/app/ui/home/home_page.dart';
import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:alamuti/app/ui/widgets/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullscreenImage extends StatelessWidget {
  final String image;
  const FullscreenImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.memory(
          base64Decode(image),
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }
}
