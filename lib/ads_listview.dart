import 'package:alamuti/Advertisement.dart';
import 'package:alamuti/ads_card.dart';
import 'package:flutter/material.dart';

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
              child: AdsCard(
                index: index,
              ));
        },
      ),
    );
  }
}
