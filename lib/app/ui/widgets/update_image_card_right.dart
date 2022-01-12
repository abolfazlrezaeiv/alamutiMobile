import 'dart:convert';
import 'package:alamuti/app/controller/update_image_advertisement_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateRightPhotoCard extends GetView<UpdateUploadImageController> {
  UpdateRightPhotoCard({Key? key}) : super(key: key);

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
          child: (controller.rightImagebyteCode.value.length > 2)
              ? Stack(
                  children: [
                    Image.memory(
                      base64Decode(controller.rightImagebyteCode.value),
                      fit: BoxFit.cover,
                    ),
                    IconButton(
                      icon: Icon(
                        CupertinoIcons.xmark_circle_fill,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        controller.rightImagebyteCode.value = '';
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
