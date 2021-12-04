import 'package:alamuti/bottom_navbar.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(8, 212, 76, 0.5),
        title: Text(
          'پیامها',
          style: TextStyle(fontSize: 19),
        ),
      ),
      bottomNavigationBar: AlamutBottomNavBar(),
    );
  }
}
