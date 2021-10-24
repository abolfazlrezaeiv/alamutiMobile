import 'package:alamuti/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 350,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    imgUrl,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40.0),
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
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 20,
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(title,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 19)),
                  Opacity(
                    opacity: 0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${price}   تومان',
                          style: TextStyle(
                              fontFamily: 'IRANSansXFaNum',
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 70,
                        ),
                        Text('قیمت',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15))
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(
              indent: 10,
              endIndent: 10,
              height: 10.0,
              thickness: 1,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Text(
                description,
                overflow: TextOverflow.fade,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
