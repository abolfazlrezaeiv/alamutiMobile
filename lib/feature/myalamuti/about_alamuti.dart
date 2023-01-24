import 'package:alamuti/feature/theme.dart';
import 'package:alamuti/feature/widgets/alamuti_appbar.dart';
import 'package:alamuti/feature/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutAlamuti extends StatelessWidget {
  AboutAlamuti({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AlamutiAppBar(
        appBar: AppBar(),
        title: 'درباره الموتی',
        hasBackButton: true,
      ),
      bottomNavigationBar: AlamutBottomNavBar(),
      body: Padding(
        padding: EdgeInsets.all(Get.width / 25),
        child: ListView(
          children: [
            SizedBox(
              height: Get.height / 50,
            ),
            Text(
              'الموتی در سال 1400 با هدف تسهیل خرید و فروش محصولات کشاورزی و تولیدات منطقه الموت آغاز به کار کرد.',
              style: TextStyle(
                  fontSize: Get.width / 27,
                  fontFamily: persianNumber,
                  fontWeight: FontWeight.w300),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(
              height: Get.height / 30,
            ),
            Text(
              'قرار دادن آگهی در الموتی',
              style: TextStyle(
                  fontSize: Get.width / 25,
                  fontFamily: persianNumber,
                  fontWeight: FontWeight.w400),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(
              height: Get.height / 70,
            ),
            Text(
              ' - گزینه ثبت آگهی را انتخاب کنید\n - دسته بندی آگهی خود را مشخص نمایید\n - شما میتوانید عکسی برای آگهی خود انتخاب کنید\n - اطلاعات و توضیحات را تکمیل نموده و آگهی را ثبت کنید',
              style: TextStyle(
                  fontSize: Get.width / 29,
                  fontFamily: persianNumber,
                  fontWeight: FontWeight.w300),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(
              height: Get.height / 30,
            ),
            Text(
              'خرید و فروش بی واسطه در الموتی',
              style: TextStyle(
                  fontSize: Get.width / 25,
                  fontFamily: persianNumber,
                  fontWeight: FontWeight.w400),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(
              height: Get.height / 70,
            ),
            Text(
              'در الموتی کاربران مستقیما با هم تماس میگیرند و دراین میان هیچ واسطه ای وجود ندارد، پس دقت فرمایید در خرید یا فروش شما الموتی هیچ گونه دخالتی ندارد و کاربران باید خودشان جنبه های مختلف امنیتی را در نظر بگیرند.',
              style: TextStyle(
                  fontSize: Get.width / 29,
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
