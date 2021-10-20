import 'package:flutter/material.dart';

void main() {
  runApp(Application());
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 50.0,
            width: 400.0,
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(112, 112, 112, 0.77),
                    width: 2.0,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[],
      ),
      body: Container(),
    );
  }
}
