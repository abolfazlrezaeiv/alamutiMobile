import 'package:alamuti/Advertisement.dart';
import 'package:flutter/material.dart';

class AdsCard extends StatelessWidget {
  final int index;
  const AdsCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  width: 170,
                  height: 200,
                  child: Image.asset(
                    ads[index].photo,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    ads[index].title,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  SizedBox(
                    height: 80.0,
                  ),
                  Text(
                    '${ads[index].price.toString()}  تومان',
                    style: TextStyle(
                        fontFamily: 'IRANSansXFaNum',
                        fontWeight: FontWeight.w300),
                  ),
                  Text(ads[index].datePosted,
                      style:
                          TextStyle(fontWeight: FontWeight.w200, fontSize: 14)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
