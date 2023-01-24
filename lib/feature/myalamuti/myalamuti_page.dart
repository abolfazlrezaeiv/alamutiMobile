import 'package:alamuti/controller/selected_tap_controller.dart';
import 'package:alamuti/data/storage/cache_manager.dart';
import 'package:alamuti/feature/alert_dialog_class.dart';
import 'package:alamuti/feature/theme.dart';
import 'package:alamuti/feature/widgets/alamuti_appbar.dart';
import 'package:alamuti/feature/widgets/bottom_navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MyAlamutiPage extends StatelessWidget with CacheManager {
  MyAlamutiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AlamutiAppBar(
        appBar: AppBar(),
        title: 'الموتی من',
        hasBackButton: false,
      ),
      bottomNavigationBar: AlamutBottomNavBar(),
      body: WillPopScope(
        onWillPop: () async {
          Get.put(ScreenController()).selectedIndex.value = 3;
          Get.offAllNamed('/home');

          return false;
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding:
                              EdgeInsets.symmetric(horizontal: Get.width / 30),
                          child: Padding(
                            padding: EdgeInsets.only(right: Get.width / 40),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Alert.logoutAlertDialog(context: context);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Get.width / 120),
                                    child: Text(
                                      'خروج ازحساب',
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(1),
                                          fontWeight: FontWeight.w300,
                                          fontSize: Get.width / 36),
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.white,
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40),
                                        side: BorderSide(
                                            color: Colors.greenAccent,
                                            width: 0.7),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width / 60,
                                ),
                                Text(
                                  'شما با شماره موبایل ${getPhonenNumber()} وارد شده اید',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      fontSize: Get.width / 35,
                                      fontFamily: persianNumber,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/myads');
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Divider(),
                                ListTile(
                                  leading: Icon(CupertinoIcons.back),
                                  title: Text(
                                    'آگهی های من',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textDirection: TextDirection.rtl,
                                  ),
                                  trailing: Icon(CupertinoIcons.house),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/about');
                          },
                          child: ListTile(
                            leading: Icon(CupertinoIcons.back),
                            title: Text(
                              'درباره الموتی',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                            trailing: Icon(CupertinoIcons.info_circle),
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/contact');
                          },
                          child: ListTile(
                            leading: Icon(CupertinoIcons.back),
                            title: Text(
                              'ارتباط با ما',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                            trailing: Icon(CupertinoIcons.question),
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
