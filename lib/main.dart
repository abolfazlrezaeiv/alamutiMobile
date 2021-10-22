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
  TextEditingController _textEditingController = TextEditingController();
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
          title: Container(
            height: 50,
            width: MediaQuery.of(context).size.width / 1.1,
            child: TextField(
              controller: _textEditingController,
              onTap: () {
                setState(() {
                  isTyping = true;
                });
              },
              onSubmitted: (value) {
                if (value == '') {
                  setState(() {
                    isTyping = false;
                  });
                }
              },
              textAlign: TextAlign.end,
              decoration: InputDecoration(
                prefixIcon: !isTyping
                    ? Padding(
                        padding: EdgeInsets.only(left: mq),
                        child: Opacity(
                          opacity: 0.5,
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/logo/logo.png',
                                width: 70,
                              ),
                              Text(
                                'جستجو در',
                                style: TextStyle(color: Colors.black),
                              )
                            ],
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
                suffixIcon: IconButton(
                  icon: Icon(
                    CupertinoIcons.search,
                    size: 40,
                    color: Color.fromRGBO(112, 112, 112, 0.5),
                  ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    _textEditingController.clear();
                  },
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
      ),
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
      body: Container(
        width: MediaQuery.of(context).size.width / 0.6,
        child: ListView.builder(
          itemCount: ads.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                height: 155.0,
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: Image.asset(
                            ads[index].photo,
                            width: 170,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              ads[index].title,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            SizedBox(
                              height: 80.0,
                            ),
                            Text(
                              '${ads[index].price.toString()}  تومان',
                              style: TextStyle(
                                  fontFamily: 'IRANSansXFaNum',
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(ads[index].datePosted,
                                style: TextStyle(
                                    fontWeight: FontWeight.w200, fontSize: 14)),
                          ],
                        ),
                      )
                    ],
                  ),
                ));
          },
        ),
      ),
    );
  }
}
