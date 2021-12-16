import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/home_page.dart';
import '../widgets/alamuti_button.dart';

class AdsDetail extends StatelessWidget {
  final String imgUrl;

  final String title;

  final String price;

  final String description;
  const AdsDetail(
      {Key? key,
      required this.imgUrl,
      required this.title,
      required this.price,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: mq.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 2.3,
                      width: MediaQuery.of(context).size.width,
                      child: Image.memory(
                        base64Decode(imgUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40.0),
                      child: Opacity(
                        opacity: 0.7,
                        child: GestureDetector(
                          onTap: () => Get.to(() => HomePage(),
                              transition: Transition.noTransition),
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
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: MediaQuery.of(context).size.width / 24),
                        textDirection: TextDirection.rtl,
                      ),
                      Opacity(
                        opacity: 0.7,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: MediaQuery.of(context).size.width / 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '$price   تومان',
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                    fontFamily: 'IRANSansXFaNum',
                                    fontWeight: FontWeight.w400),
                              ),
                              Text('قیمت',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  indent: 10,
                  endIndent: 10,
                  height: MediaQuery.of(context).size.width / 40,
                  thickness: 1,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14.0, vertical: 0),
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      description,
                      maxLines: 8,
                      overflow: TextOverflow.visible,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: MediaQuery.of(context).size.width / 28,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: MediaQuery.of(context).size.height / 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      height: MediaQuery.of(context).size.width / 8,
                      minWidth: mq.width / 2.2,
                      elevation: 0,
                      color: Color.fromRGBO(255, 0, 0, 0.4),
                      onPressed: () => null,
                      child: Text('تماس تلفنی'),
                    ),
                    MaterialButton(
                      height: MediaQuery.of(context).size.width / 8,
                      minWidth: mq.width / 2.2,
                      elevation: 0,
                      color: Color.fromRGBO(255, 0, 0, 0.4),
                      onPressed: () => null,
                      child: Text('چت'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
