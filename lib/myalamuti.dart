import 'package:flutter/material.dart';

import 'bottom_navbar.dart';

class MyAlamuti extends StatelessWidget {
  const MyAlamuti({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(8, 212, 76, 0.5),
        title: Text(
          'الموتی من',
          style: TextStyle(fontSize: 19),
        ),
      ),
      bottomNavigationBar: AlamutBottomNavBar(),
    );
  }
}
