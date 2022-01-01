import 'package:alamuti/app/controller/authentication_manager.dart';
import 'package:alamuti/app/data/storage/cachemanager.dart';
import 'package:alamuti/app/ui/home/home_page.dart';
import 'package:alamuti/app/ui/myalamuti/myadvertisement.dart';
import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:alamuti/app/ui/widgets/alamuti_button.dart';
import 'package:alamuti/app/ui/widgets/bottom_navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAlamutiPage extends StatelessWidget with CacheManager {
  const MyAlamutiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    final AuthenticationManager auth = Get.put(AuthenticationManager());
    return Scaffold(
      appBar: AlamutiAppBar(
        appBar: AppBar(),
        title: 'الموتی من',
        hasBackButton: false,
        backwidget: HomePage(),
      ),
      bottomNavigationBar: AlamutBottomNavBar(),
      body: Padding(
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                auth.logOut();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  'خروج ازحساب',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(1),
                                      fontWeight: FontWeight.w300,
                                      fontSize: Get.width / 33),
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
                                        color: Colors.black.withOpacity(0.4),
                                        width: 0.7),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width / 40,
                            ),
                            Text(
                              'شما با شماره موبایل ${getPhonenNumber()} وارد شده اید',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  fontSize: Get.width / 29,
                                  fontFamily: 'IRANSansXFaNum',
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(MyAdvertisement());
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
                      ListTile(
                        leading: Icon(CupertinoIcons.back),
                        title: Text(
                          'درباره الموتی',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        trailing: Icon(CupertinoIcons.house),
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
    );
  }
}
