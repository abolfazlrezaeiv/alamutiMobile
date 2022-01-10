import 'package:alamuti/app/controller/adsFormController.dart';
import 'package:alamuti/app/controller/advertisementController.dart';
import 'package:alamuti/app/controller/myAdvertisementController.dart';
import 'package:alamuti/app/controller/search_keyword.dart';
import 'package:alamuti/app/data/model/Advertisement.dart';
import 'package:alamuti/app/data/provider/token_provider.dart';
import 'package:alamuti/app/data/provider/base_url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';

class AdvertisementProvider {
  var tokenProvider = Get.put(TokenProvider());

  var adsFormController = Get.put(AdsFormController());

  var listAdvertisementController = Get.put(ListAdvertisementController());

  var myAdvertisementController = Get.put(MyAdvertisementController());

  var searchKeywordController = Get.put(SearchKeywordController());

  Future<void> deleteAds(int id) async {
    for (var i = 0; i < myAdvertisementController.adsList.length; i++) {
      if (myAdvertisementController.adsList[i].id == id) {
        myAdvertisementController.adsList.removeAt(i);
        break;
      }
    }

    await tokenProvider.api.delete(baseUrl + 'Advertisement/$id');
  }

  Future<List<Advertisement>> getMyAds() async {
    var response =
        await tokenProvider.api.get(baseUrl + 'Advertisement/myalamuti/myAds');

    var myMap = response.data;
    List<Advertisement> myads = [];
    myMap.forEach(
      (element) {
        myads.add(Advertisement(
          id: element['id'],
          title: element['title'],
          description: element['description'],
          datePosted: element['daySended'],
          price: element['price'].toString(),
          photo1: element['photo1'],
          photo2: element['photo2'],
          area: element['area'].toString(),
          userId: element['userId'],
          published: element['published'],
          phoneNumber: element['phoneNumber'],
          adsType: element['adsType'],
          village: element['village'],
        ));
      },
    );

    myAdvertisementController.adsList.value = myads;
    return myads;
  }

  Future<List<Advertisement>> search(String searchInput) async {
    var response = await tokenProvider.api
        .get(baseUrl + 'Advertisement/search/$searchInput');

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
            photo1: element['photo1'],
            photo2: element['photo2'],
            area: element['area'].toString(),
            userId: element['userId'],
            published: element['published'],
            phoneNumber: element['phoneNumber'],
            village: element['village'],
            adsType: element['adsType'],
          ),
        );
      },
    );

    if (myads.length == 0) {
      Get.rawSnackbar(
          messageText: Text(
            'موردی یافت نشد',
            style: TextStyle(color: Colors.white),
            textDirection: TextDirection.rtl,
          ),
          backgroundColor: Colors.black);
      return myads;
    }
    listAdvertisementController.adsList.value = myads;
    searchKeywordController.keyword.value = searchInput;
    return myads;
  }

  Future<void> getAll([String? adstype]) async {
    var response;
    if (adstype == null || adstype.isEmpty == true) {
      response = await tokenProvider.api.get(
        baseUrl + 'Advertisement',
      );
    } else {
      response = await tokenProvider.api.get(
        baseUrl + 'Advertisement/filter/$adstype',
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
            photo1: element['photo1'],
            photo2: element['photo2'],
            area: element['area'].toString(),
            userId: element['userId'],
            adsType: element['adsType'],
            phoneNumber: element['phoneNumber'],
            village: element['village'],
            published: element['published'],
          ),
        );
      },
    );

    listAdvertisementController.adsList.value = myads;
  }

  Future<void> postAdvertisement(
      {required String title,
      required String description,
      required int price,
      required int area,
      required String photo1,
      required String village,
      required String photo2}) async {
    var formData = FormData.fromMap({
      'title': title,
      'description': description,
      'price': price,
      'photo1': photo1,
      'photo2': photo2,
      'area': area,
      'village': village,
      'adsType': adsFormController.formState.value.toString().toLowerCase(),
    });

    await tokenProvider.api.post(
      baseUrl + 'Advertisement',
      data: formData,
    );
  }

  updateAdvertisement(
      {required String title,
      required int id,
      required String description,
      required int price,
      required int area,
      required String photo1,
      required String village,
      required String photo2}) async {
    var formData = FormData.fromMap({
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'photo1': photo1,
      'photo2': photo2,
      'area': area,
      'village': village,
      'adsType': adsFormController.formState.value.toString().toLowerCase(),
    });
    await tokenProvider.api.put(
      baseUrl + 'Advertisement',
      data: formData,
    );
  }
}
