import 'dart:convert';

import 'package:alamuti/data/entities/advertisement/advertisement.dart';
import 'package:alamuti/presentation/common/strings/app_asset.dart';
import 'package:alamuti/presentation/themes/theme.dart';
import 'package:flutter/material.dart';

class SingleAdvertisementItem extends StatelessWidget {
  final Advertisement item;
  const SingleAdvertisementItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.transparent, width: 0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.only(top: 8, bottom: 6, left: 8, right: 8),
      elevation: 12,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.cover,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: (item.listViewPhoto != null)
                      ? Image.memory(
                          base64Decode(item.listViewPhoto!),
                          fit: BoxFit.cover,
                          height: 120,
                          width: 120,
                        )
                      : SizedBox(
                          height: 120,
                          width: 120,
                          child: Image.asset(
                            AppAsset.SEARCH_FIELD_LOGO,
                            fit: BoxFit.cover,
                          ),
                        )),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      item.title,
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                      textDirection: TextDirection.rtl,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Text(
                      'تومان ${item.price.toString()}',
                      style: TextStyle(
                          fontFamily: persianNumber,
                          fontWeight: FontWeight.w300),
                      textDirection: TextDirection.rtl,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          item.daySended,
                          style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontFamily: persianNumber,
                              fontSize: 13),
                          textDirection: TextDirection.rtl,
                        ),
                        // SizedBox(
                        //   width: 2,
                        // ),
                        Text(
                          item.village,
                          style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontFamily: persianNumber,
                              fontSize: 13),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
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
