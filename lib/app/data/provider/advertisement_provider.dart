import 'package:alamuti/app/controller/adsFormController.dart';
import 'package:alamuti/app/data/model/Advertisement.dart';
import 'package:alamuti/app/controller/token_provider.dart';
import 'package:dio/dio.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/utils.dart';

class AdvertisementProvider {
  TokenProvider tokenProvider = Get.put(TokenProvider());
  AdsFormController adsFormController = Get.put(AdsFormController());

  Future<void> deleteAds(int id) async {
    var response = await tokenProvider.api
        .delete('http://192.168.1.102:5113/api/Advertisement/${id}');
  }

  Future<List<Advertisement>> getMyAds() async {
    var response = await tokenProvider.api
        .get('http://192.168.1.102:5113/api/Advertisement/myalamuti/myAds');

    var myMap = response.data;
    List<Advertisement> myads = [];
    myMap.forEach((element) {
      myads.add(Advertisement(
          id: element['id'],
          title: element['title'],
          description: element['description'],
          datePosted: element['daySended'],
          price: element['price'].toString(),
          photo: element['photo1'],
          area: element['area'].toString(),
          userId: element['userId'],
          adsType: element['adsType']));
    });
    print(myads.length);
    return myads;
  }

  Future<List<Advertisement>> findAll([String? searchInput = null]) async {
    print('search called');
    var response;
    if (searchInput == null) {
      print('input is null');
      response = await tokenProvider.api.get(
        'http://192.168.1.102:5113/api/Advertisement',
      );
    } else {
      print('searching');
      response = await tokenProvider.api.get(
        'http://192.168.1.102:5113/api/Advertisement/find/${searchInput}',
      );
    }

    var myMap = response.data;
    List<Advertisement> myads = [];
    myMap.forEach((element) {
      myads.add(Advertisement(
        id: element['id'],
        title: element['title'],
        description: element['description'],
        datePosted: element['daySended'],
        price: element['price'].toString(),
        photo: element['photo2'],
        area: element['area'].toString(),
        userId: element['userId'],
        adsType: element['adsType'],
      ));
    });
    print(myads.length);
    return myads;
  }

  Future<List<Advertisement>> getAll([String? adstype]) async {
    var response;
    if (adstype == null) {
      response = await tokenProvider.api.get(
        'http://192.168.1.102:5113/api/Advertisement',
      );
    } else {
      response = await tokenProvider.api.get(
        'http://192.168.1.102:5113/api/Advertisement/filter/${adstype}',
      );
    }

    var myMap = response.data;
    List<Advertisement> myads = [];
    myMap.forEach(
      (element) {
        myads.add(
          Advertisement(
            id: element['id'],
            title: element['title'],
            description: element['description'],
            datePosted: element['daySended'],
            price: element['price'].toString(),
            photo: element['photo1'],
            area: element['area'].toString(),
            userId: element['userId'],
            adsType: element['adsType'],
          ),
        );
      },
    );
    print(myads.length);
    return myads;
  }

  postAdvertisement(
      {required String title,
      required String description,
      required int price,
      required int area,
      required String photo1,
      required String photo2}) async {
    var formData = FormData.fromMap({
      'title': title,
      'description': description,
      'price': price,
      'photo1': photo1,
      'photo2': photo2,
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

  updateAdvertisement(
      {required String title,
      required int id,
      required String description,
      required int price,
      required int area,
      required String photo1,
      required String photo2}) async {
    var formData = FormData.fromMap({
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'photo1': photo1,
      'photo2': photo2,
      'area': area,
      'adsType': adsFormController.formState.value.toString().toLowerCase(),
    });
    var response = await tokenProvider.api.put(
      'http://192.168.1.102:5113/api/Advertisement',
      data: formData,
    );
    print(response.statusMessage);
    print(response.statusCode);
  }
}
