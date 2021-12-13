import 'package:alamuti/app/data/model/Advertisement.dart';
import 'package:alamuti/app/data/provider/advertisement_provider.dart';
import 'package:alamuti/app/data/provider/token_provider.dart';
import 'package:alamuti/app/ui/details/detail_page.dart';
import 'package:alamuti/app/ui/widgets/ads_card.dart';
import 'package:alamuti/app/ui/widgets/bottom_navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var ap = AdvertisementProvider();
    ap.getAll();
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
      body: ListView.builder(
        itemCount: ads.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              height: 155.0,
              child: GestureDetector(
                onTap: () => Get.to(
                    () => AdsDetail(
                          imgUrl: ads[index].photo,
                          price: ads[index].price.toString(),
                          title: ads[index].title,
                          description: ads[index].description,
                        ),
                    transition: Transition.noTransition),
                child: AdsCard(
                  index: index,
                ),
              ));
        },
      ),
    );
  }
}
