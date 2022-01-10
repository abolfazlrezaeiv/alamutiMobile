import 'package:alamuti/app/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PriceController extends GetxController {
  var price = ''.obs;

  Widget getPersianPriceHint() {
    var commaAddedPrice = price
        .split('')
        .reversed
        .join()
        .replaceAllMapped(RegExp(r".{3}"), (match) => "${match.group(0)},")
        .split('')
        .reversed
        .join();
    if (commaAddedPrice.startsWith(',')) {
      commaAddedPrice = commaAddedPrice.substring(1, commaAddedPrice.length);
    }
    if (commaAddedPrice.endsWith(',')) {
      commaAddedPrice =
          commaAddedPrice.substring(0, commaAddedPrice.length - 1);
    }

    var result = commaAddedPrice;

    // return result;

    return Text(
      price.isNotEmpty ? 'تومان $result' : '',
      style: TextStyle(
          fontSize: Get.width / 35,
          fontWeight: FontWeight.w300,
          fontFamily: persianNumber),
      textDirection: TextDirection.rtl,
    );
  }
}
