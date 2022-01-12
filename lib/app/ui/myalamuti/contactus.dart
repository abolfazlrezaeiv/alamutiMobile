import 'package:alamuti/app/ui/myalamuti/myalamuti_page.dart';
import 'package:alamuti/app/ui/theme.dart';
import 'package:alamuti/app/ui/widgets/alamuti_appbar.dart';
import 'package:alamuti/app/ui/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactPage extends StatelessWidget {
  ContactPage({Key? key}) : super(key: key);

  final double width = Get.width;

  final double height = Get.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AlamutiAppBar(
        appBar: AppBar(),
        title: 'ارتباط با ما',
        backwidget: "/myalamuti",
        hasBackButton: true,
      ),
      bottomNavigationBar: AlamutBottomNavBar(),
      body: Padding(
        padding: EdgeInsets.all(width / 25),
        child: ListView(
          children: [
            SizedBox(
              height: height / 50,
            ),
            Text(
              'انتقادات و پیشنهادات، سوالات خود در ارتباط با فرآیند ثبت آگهی را از طریق راه های ارتباطی زیر با ما در میان بگذارید.',
              style: TextStyle(
                  fontSize: width / 27,
                  fontFamily: persianNumber,
                  fontWeight: FontWeight.w300),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(
              height: height / 30,
            ),
            Text(
              'مدت زمان پاسخگویی به پیامها',
              style: TextStyle(
                  fontSize: width / 25,
                  fontFamily: persianNumber,
                  fontWeight: FontWeight.w400),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(
              height: height / 70,
            ),
            Text(
              'تمامی ایمیل ها و پیامهای شما روزانه بررسی و پاسخ داده میشوند و زمان پاسخگویی به پیام ها بین 3 تا 24 ساعت خواهد بود. پیشاپیش از صبر و شکیبایی شما صمیمانه سپاسگذاریم.',
              style: TextStyle(
                  fontSize: width / 29,
                  fontFamily: persianNumber,
                  fontWeight: FontWeight.w300),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(
              height: height / 30,
            ),
            Text(
              'راه های ارتباطی',
              style: TextStyle(
                  fontSize: width / 25,
                  fontFamily: persianNumber,
                  fontWeight: FontWeight.w400),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(
              height: height / 70,
            ),
            Text(
              'ایمیل : alamuti.ir@gmail.com',
              style: TextStyle(
                  fontSize: width / 29,
                  fontFamily: persianNumber,
                  fontWeight: FontWeight.w300),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(
              height: height / 150,
            ),
            Text(
              'واتس آپ : 09904640760',
              style: TextStyle(
                  fontSize: width / 29,
                  fontFamily: persianNumber,
                  fontWeight: FontWeight.w300),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }
}
