// import 'package:alamuti/app/controller/adsFormController.dart';
// import 'package:alamuti/app/data/model/Advertisement.dart';
// import 'package:alamuti/app/data/provider/token_provider.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/state_manager.dart';

import 'package:alamuti/app/controller/adsFormController.dart';
import 'package:alamuti/app/data/model/Advertisement.dart';
import 'package:alamuti/app/data/provider/token_provider.dart';
import 'package:dio/dio.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/utils.dart';

class AdvertisementProvider {
  TokenProvider tokenProvider = Get.put(TokenProvider());
  AdsFormController adsFormController = Get.put(AdsFormController());

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

  postAdvertisement(
      {required String title,
      required String description,
      required int price,
      required int area,
      required String photo}) async {
    var formData = FormData.fromMap({
      'title': title,
      'description': description,
      'price': price,
      'photo': photo,
      'area': area,
      'adsType': adsFormController.formState.value.toString().toLowerCase(),
    });
    var response = await tokenProvider.api.post(
      'http://192.168.1.102:5113/api/Advertisement',
      data: formData,
    );
    print(response.statusMessage);
    print(response.statusCode);
  }
}
