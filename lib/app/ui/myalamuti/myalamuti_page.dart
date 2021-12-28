import 'package:alamuti/app/controller/authentication_manager.dart';
import 'package:alamuti/app/ui/home/home_page.dart';
import 'package:alamuti/app/ui/myalamuti/myadvertisement.dart';
import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:alamuti/app/ui/widgets/alamuti_button.dart';
import 'package:alamuti/app/ui/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAlamutiPage extends StatelessWidget {
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
                Card(
                  elevation: 0.3,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => Get.to(MyAdvertisement()),
                          child: Text(
                            'آگهی های من',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w300),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.account_circle_outlined),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 0.3,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'درباره الموتی',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.info_outline_rounded),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: mq.width,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => auth.logOut(),
                          child: Text(
                            'خروج از حساب',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 40,
                        ),
                        Text(
                          'شما با شماره ۰۹۹۰۴۶۴۰۷۶۰ وارد شده اید',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
