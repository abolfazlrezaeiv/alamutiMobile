import 'dart:convert';

import 'package:alamuti/domain/controllers/update_image_advertisement_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateLeftPhotoCard extends StatelessWidget {
  UpdateLeftPhotoCard({Key? key}) : super(key: key);

  final UpdateUploadImageController updateUploadImageController =
      Get.put(UpdateUploadImageController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.width / 3,
      width: Get.width / 3,
      child: Obx(
        () => Card(
          elevation: 3,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: (updateUploadImageController.leftImagebyteCode.value.length >
                  2)
              ? Stack(
                  children: [
                    Image.memory(
                      base64Decode(
                          updateUploadImageController.leftImagebyteCode.value),
                      fit: BoxFit.cover,
                    ),
                    IconButton(
                      icon: Icon(
                        CupertinoIcons.xmark_circle_fill,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        updateUploadImageController.leftImagebyteCode.value =
                            '';
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
