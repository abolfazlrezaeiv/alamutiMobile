import 'dart:convert';
import 'package:flutter/material.dart';

class FullscreenImage extends StatelessWidget {
  final String image;
  const FullscreenImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: FractionallySizedBox(
          heightFactor: 0.7,
          widthFactor: 1,
          child: Image.memory(
            base64Decode(image),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
