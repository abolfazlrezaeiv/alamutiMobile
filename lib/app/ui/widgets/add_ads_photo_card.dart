import 'package:flutter/material.dart';

class AddPhotoWidget extends StatelessWidget {
  const AddPhotoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 5.5,
      width: MediaQuery.of(context).size.width / 3.8,
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 14),
        child: Column(
          children: [
            Icon(
              Icons.add_a_photo,
              size: 50,
              color: Colors.grey,
            ),
            Text(
              'افزودن عکس',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: MediaQuery.of(context).size.width / 40),
            )
          ],
        ),
      ),
    );
  }
}
