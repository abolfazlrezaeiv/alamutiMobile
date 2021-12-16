import 'dart:convert';
import 'dart:io';
import 'package:alamuti/app/controller/ConnectionController.dart';
import 'package:alamuti/app/data/model/Advertisement.dart';
import 'package:alamuti/app/data/provider/advertisement_provider.dart';
import 'package:alamuti/app/ui/details/detail_page.dart';
import 'package:alamuti/app/ui/imgaebase64.dart';
import 'package:alamuti/app/ui/widgets/bottom_navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTap = 4;
  bool isTyping = false;
  TextEditingController _textEditingController = TextEditingController();
  var ap = AdvertisementProvider();
  List<Advertisement> adsList = [];
  ConnectionController connectionController = Get.put(ConnectionController());

  @override
  void initState() {
    super.initState();
    ap.getAll().then((value) {
      if (value == null) {
        print('value is null');
      }
      setState(() {
        adsList = value;
      });
      print(adsList.length);
    });

    connectionController.checkConnectionStatus();
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom == 0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 4,
          backgroundColor: Colors.white,
          title: Container(
            height: 50,
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
                prefixIcon: isKeyboardOpen
                    ? Opacity(
                        opacity: 0.5,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 2.3),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/logo/logo.png',
                                width: 60,
                              ),
                              Text(
                                'جستجو در',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17),
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
                    size: 30,
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
      bottomNavigationBar: AlamutBottomNavBar(),
      body: (!connectionController.isConnected.value)
          ? Center(
              child: Text('لطفا اتصال به اینترنت همراه خود را بررسی کنید'),
            )
          : ListView.builder(
              itemCount: adsList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    height: 155.0,
                    child: GestureDetector(
                        onTap: () => Get.to(
                            () => AdsDetail(
                                  imgUrl: adsList[index].photo ?? image64,
                                  price: adsList[index].price.toString(),
                                  title: adsList[index].title,
                                  description: adsList[index].description,
                                ),
                            transition: Transition.noTransition),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.withOpacity(0.3),
                              ),
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width / 35),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.2,
                                    height:
                                        MediaQuery.of(context).size.height / 5,
                                    child: Image.memory(
                                      base64Decode(
                                          adsList[index].photo ?? image64),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 3.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          adsList[index].title,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                          textDirection: TextDirection.rtl,
                                        ),
                                        SizedBox(
                                          height: 75.0,
                                        ),
                                        Text(
                                          '${adsList[index].price.toString()}  تومان',
                                          style: TextStyle(
                                              fontFamily: 'IRANSansXFaNum',
                                              fontWeight: FontWeight.w300),
                                        ),
                                        Text(
                                          adsList[index].datePosted,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w200,
                                              fontFamily: 'IRANSansXFaNum',
                                              fontSize: 14),
                                          textDirection: TextDirection.rtl,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )));
              },
            ),
    );
  }
}
