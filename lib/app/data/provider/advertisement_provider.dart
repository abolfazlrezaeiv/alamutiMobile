import 'dart:convert';
import 'dart:ffi';

import 'package:alamuti/app/data/model/Advertisement.dart';
import 'package:alamuti/app/data/provider/token_provider.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class AdvertisementProvider {
  TokenProvider tokenProvider = Get.put(TokenProvider());

  Future<List<Advertisement>> getAll() async {
    var response = await tokenProvider.api.get(
      'http://192.168.1.102:5113/api/Advertisement',
    );

    var myMap = response.data;
    List<Advertisement> myads = [];
    myMap.forEach((element) {
      myads.add(Advertisement(
        id: element['id'],
        title: element['title'],
        description: element['description'],
        datePosted: element['daySended'],
        price: element['price'],
        photo: element['photo'],
      ));
    });
    print(myads.length);
    return myads;
  }
}
