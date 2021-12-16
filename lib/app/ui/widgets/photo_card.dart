import 'dart:convert';

import 'package:flutter/material.dart';

class PhotoCard extends StatelessWidget {
  const PhotoCard({
    Key? key,
    required this.imageByte,
  }) : super(key: key);
  final String imageByte;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 6,
      width: MediaQuery.of(context).size.width / 3.0,
      child: Card(
        elevation: 2,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Colors.grey[100],
        child: (imageByte.length > 2)
            ? Container(
                child: Image.memory(
                base64Decode(imageByte),
                fit: BoxFit.cover,
              ))
            : Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width / 14),
                child: Icon(
                  Icons.photo_outlined,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
      ),
    );
  }
}
