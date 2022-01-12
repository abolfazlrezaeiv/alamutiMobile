import 'dart:convert';
import 'package:alamuti/app/controller/upload_image_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RightPhotoCard extends StatelessWidget {
  RightPhotoCard({Key? key}) : super(key: key);

  final UploadImageController uploadImageController =
      Get.put(UploadImageController());

  final double width = Get.width;

  final double height = Get.height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width / 3,
      width: width / 3,
      child: Obx(
        () => Card(
          elevation: 3,
          clipBehavior: Clip.antiAliasWithSaveLayer,
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
                  padding: EdgeInsets.all(width / 14),
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
