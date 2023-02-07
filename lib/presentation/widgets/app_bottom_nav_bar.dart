import 'package:flutter/material.dart';

class AppBottomNavigationBar extends StatelessWidget {
  AppBottomNavigationBar({
    Key? key,
  }) : super(key: key);

  final List<IconData> icons = [
    Icons.home,
    Icons.search,
    Icons.person,
    Icons.settings,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8.0,
            spreadRadius: 3.0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
        child: BottomNavigationBar(
          selectedIconTheme: IconThemeData(color: Colors.grey),
          backgroundColor: Colors.black,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0.0,
          items: icons.map((icon) {
            return BottomNavigationBarItem(icon: Icon(icon), label: '');
          }).toList(),
          currentIndex: 3,
          onTap: (value) {},
        ),
      ),
    );
  }
}
