import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPhotoWidget extends StatelessWidget {
  AddPhotoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(Get.width / 13),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
