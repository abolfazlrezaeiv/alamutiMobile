import 'package:alamuti/Advertisement.dart';
import 'package:alamuti/ads_card.dart';
import 'package:alamuti/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdsListView extends StatelessWidget {
  const AdsListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
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
                ),
                child: AdsCard(
                  index: index,
                ),
              ));
        },
      ),
    );
  }
}
