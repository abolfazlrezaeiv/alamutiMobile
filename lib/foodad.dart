import 'package:alamuti/bottom_navbar.dart';
import 'package:flutter/cupertino.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width / 10),
                      child: Icon(CupertinoIcons.photo_camera),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width / 10),
                      child: Icon(CupertinoIcons.photo_camera),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width / 10),
                      child: Icon(CupertinoIcons.photo_camera),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                height: 100,
                child: Text(
                  'عنوان',
                  style: TextStyle(fontSize: 25),
                  textDirection: TextDirection.rtl,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
