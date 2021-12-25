import 'dart:convert';

import 'package:alamuti/app/controller/upload_image_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RightPhotoCard extends StatelessWidget {
  RightPhotoCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UploadImageController uploadImageController =
        Get.put(UploadImageController());

    return Obx(
      () => Container(
        height: MediaQuery.of(context).size.height / 6,
        width: MediaQuery.of(context).size.width / 3.0,
        child: Card(
          elevation: 2,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Colors.grey[100],
          child: (uploadImageController.rightImagebyteCode.value.length > 2)
              ? Stack(
                  children: [
                    Image.memory(
                      base64Decode(
                          uploadImageController.rightImagebyteCode.value),
                      fit: BoxFit.cover,
                    ),
                    IconButton(
                      icon: Icon(
                        CupertinoIcons.xmark_circle_fill,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        uploadImageController.rightImagebyteCode.value = '';
                      },
                    )
                  ],
                  fit: StackFit.expand,
                )
              : Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 14),
                  child: Icon(
                    Icons.photo_outlined,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
        ),
      ),
    );
  }
}
