import 'package:flutter/material.dart';

class AlamutiButton extends StatelessWidget {
  const AlamutiButton({
    Key? key,
    required this.elevation,
    required this.height,
    required this.color,
    required this.func,
    required this.title,
    required this.width,
  }) : super(key: key);
  final double elevation;
  final double height;
  final Color color;
  final Function() func;
  final String title;
  final double width;
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return SizedBox(
      width: mq.width / 1.1,
      height: 45,
      child: TextButton(
        style: ElevatedButton.styleFrom(
          primary: Color.fromRGBO(255, 0, 0, 0.4),
        ),
        onPressed: func,
        child: Text(title),
      ),
    );
  }
}
