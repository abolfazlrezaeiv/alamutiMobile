import 'package:flutter/material.dart';

class PhotoCard extends StatelessWidget {
  const PhotoCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 14),
        child: Icon(
          Icons.photo_outlined,
          size: 50,
          color: Colors.grey,
        ),
      ),
    );
  }
}
