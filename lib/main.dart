import 'package:alamuti/Advertisement.dart';
import 'package:alamuti/statics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Application());
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'IRANSansX',
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color.fromRGBO(8, 212, 76, 0.5),
          unselectedIconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTap = 4;
  bool isTyping = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedTap,
        onTap: (value) {
          setState(() {
            selectedTap = value;
          });
        },
        items: bottomTapItems,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width / 1.1,
                child: TextField(
                  onTap: () {
                    setState(() {
                      isTyping = true;
                    });
                  },
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'جستجو در ',
                    prefixIcon: !isTyping
                        ? Padding(
                            padding: const EdgeInsets.only(left: 130.0),
                            child: Opacity(
                              opacity: 0.5,
                              child: Image.asset(
                                'assets/logo/logo.png',
                                width: 70,
                              ),
                            ),
                          )
                        : Text(''),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(112, 112, 112, 0.2),
                        width: 2.0,
                      ),
                    ),
                    suffixIcon: Icon(
                      CupertinoIcons.search,
                      size: 40,
                      color: Color.fromRGBO(112, 112, 112, 0.5),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(112, 112, 112, 0.2),
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: ads.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        height: 150.0, width: 100.0, child: Card());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
