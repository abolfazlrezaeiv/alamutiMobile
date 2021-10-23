import 'package:alamuti/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdsDetail extends StatelessWidget {
  final String imgUrl;
  const AdsDetail({Key? key, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  Image.asset(
                    imgUrl,
                    fit: BoxFit.contain,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40.0, left: 10),
                    child: Opacity(
                      opacity: 0.7,
                      child: GestureDetector(
                        onTap: () => Get.to(() => HomePage()),
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.back,
                              size: 31,
                              color: Colors.white,
                            ),
                            Text(
                              'بازگشت',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
                alignment: Alignment.topLeft,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
