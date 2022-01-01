import 'dart:convert';
import 'package:alamuti/app/controller/update_image_advertisement.dart';
import 'package:alamuti/app/controller/upload_image_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateRightPhotoCard extends StatelessWidget {
  UpdateRightPhotoCard({
    Key? key,
  }) : super(key: key);
  UpdateUploadImageController updateUploadImageController =
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
          // color: Colors.grey[100],
          child: (updateUploadImageController.rightImagebyteCode.value.length >
                  2)
              ? Stack(
                  children: [
                    Image.memory(
                      base64Decode(
                          updateUploadImageController.rightImagebyteCode.value),
                      fit: BoxFit.cover,
                    ),
                    IconButton(
                      icon: Icon(
                        CupertinoIcons.xmark_circle_fill,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        updateUploadImageController.rightImagebyteCode.value =
                            '';
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
