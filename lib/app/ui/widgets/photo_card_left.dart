import 'dart:convert';
import 'package:alamuti/app/controller/upload_image_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeftPhotoCard extends GetView<UploadImageController> {
  LeftPhotoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.width / 3,
      width: Get.width / 3,
      child: Obx(
        () => Card(
          elevation: 3,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: (controller.leftImagebyteCode.value.length > 2)
              ? Stack(
                  children: [
                    Image.memory(
                      base64Decode(controller.leftImagebyteCode.value),
                      fit: BoxFit.cover,
                    ),
                    IconButton(
                      icon: Icon(
                        CupertinoIcons.xmark_circle_fill,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        controller.leftImagebyteCode.value = '';
                      },
                    )
                  ],
                  fit: StackFit.expand,
                )
              : Padding(
                  padding: EdgeInsets.all(Get.width / 14),
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
