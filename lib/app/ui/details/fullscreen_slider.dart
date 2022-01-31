import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';

class FullscreenImageSlider extends StatelessWidget {
  final String image1;
  final String image2;

  const FullscreenImageSlider(
      {Key? key, required this.image1, required this.image2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: ImageSlideshow(
          width: double.infinity,
          height: Get.height / 3,
          initialPage: 0,
          indicatorColor: Colors.greenAccent,
          indicatorBackgroundColor: Colors.white,
          children: [
            Image.memory(
              base64Decode(image1),
              fit: BoxFit.cover,
            ),
            Image.memory(
              base64Decode(image2),
              fit: BoxFit.cover,
            ),
          ],
          autoPlayInterval: null,
          isLoop: true,
        ),
      ),
    );
  }
}
