import 'package:alamuti/bottom_navbar.dart';
import 'package:flutter/material.dart';

class FoodAdForm extends StatelessWidget {
  const FoodAdForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ثبت آگهی'),
          backgroundColor: Color.fromRGBO(8, 212, 76, 0.5),
          automaticallyImplyLeading: false,
        ),
        bottomNavigationBar: AlamutBottomNavBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
          child: GridView.count(
            children: [
              Card(),
              Card(),
              Card(),
              Card(),
              Card(),
              Card(),
            ],
            crossAxisCount: 3,
          ),
        ));
  }
}
