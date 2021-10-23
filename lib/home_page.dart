import 'package:alamuti/ads_listview.dart';
import 'package:alamuti/bottom_navbar.dart';
import 'package:alamuti/searchbar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTap = 4;
  bool isTyping = false;
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size.width / 3;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0), // here the desired height
        child: AppBar(
          elevation: 4,
          backgroundColor: Colors.white,
          title: AlamutSearchBar(mq: mq),
        ),
      ),
      bottomNavigationBar: AlamutBottomNavBar(),
      body: AdsListView(),
    );
  }
}
