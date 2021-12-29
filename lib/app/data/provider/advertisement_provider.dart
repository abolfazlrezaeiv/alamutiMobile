import 'package:alamuti/app/controller/adsFormController.dart';
import 'package:alamuti/app/controller/advertisementController.dart';
import 'package:alamuti/app/controller/myAdvertisementController.dart';
import 'package:alamuti/app/data/model/Advertisement.dart';
import 'package:alamuti/app/controller/token_provider.dart';
import 'package:alamuti/app/data/provider/base_url.dart';
import 'package:alamuti/app/ui/myalamuti/myadvertisement.dart';
import 'package:dio/dio.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/utils.dart';

class AdvertisementProvider {
  TokenProvider tokenProvider = Get.put(TokenProvider());
  AdsFormController adsFormController = Get.put(AdsFormController());
  ListAdvertisementController listAdvertisementController =
      Get.put(ListAdvertisementController());
  MyAdvertisementController myAdvertisementController =
      Get.put(MyAdvertisementController());

  Future<void> deleteAds(int id) async {
    for (var i = 0; i < myAdvertisementController.adsList.length; i++) {
      if (myAdvertisementController.adsList[i].id == id) {
        myAdvertisementController.adsList.removeAt(i);
        break;
      }
    }

    var response =
        await tokenProvider.api.delete(baseUrl + 'Advertisement/${id}');
  }

  Future<List<Advertisement>> getMyAds() async {
    var response =
        await tokenProvider.api.get(baseUrl + 'Advertisement/myalamuti/myAds');

    var myMap = response.data;
    List<Advertisement> myads = [];
    myMap.forEach((element) {
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
          adsType: element['adsType']));
    });
    myAdvertisementController.adsList.value = myads;
    return myads;
  }

  Future<List<Advertisement>> findAll([String? searchInput = null]) async {
    print('search called');
    var response;
    if (searchInput == null) {
      print('input is null');
      response = await tokenProvider.api.get(
        baseUrl + 'Advertisement',
      );
    } else {
      print('searching');
      response = await tokenProvider.api.get(
        baseUrl + 'Advertisement/find/${searchInput}',
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
        photo1: element['photo1'],
        photo2: element['photo2'],
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
          ),
        );
      },
    );
    print(myads.length);
    listAdvertisementController.adsList.value = myads;

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
      baseUrl + 'Advertisement',
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
      baseUrl + 'Advertisement',
      data: formData,
    );
    print(response.statusMessage);
    print(response.statusCode);
  }
}
