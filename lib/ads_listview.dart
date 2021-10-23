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
      width: MediaQuery.of(context).size.width / 0.6,
      child: ListView.builder(
        itemCount: ads.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              height: 155.0,
              child: GestureDetector(
                onTap: () => Get.to(() => AdsDetail(imgUrl: ads[index].photo)),
                child: AdsCard(
                  index: index,
                ),
              ));
        },
      ),
    );
  }
}
