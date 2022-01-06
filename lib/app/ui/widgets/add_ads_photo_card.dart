import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';

class AddPhotoWidget extends StatelessWidget {
  const AddPhotoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 5.5,
      width: Get.width / 3.8,
      child: Padding(
        padding: EdgeInsets.all(Get.width / 20),
        child: Column(
          children: [
            Icon(
              Icons.add_a_photo,
              size: 50,
              color: Colors.grey,
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              'افزودن عکس',
              style: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: Get.width / 40),
            )
          ],
        ),
      ),
    );
  }
}
