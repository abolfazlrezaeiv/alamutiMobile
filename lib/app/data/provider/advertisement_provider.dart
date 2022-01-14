import 'package:alamuti/app/controller/ads_form_controller.dart';
import 'package:alamuti/app/controller/advertisement_controller.dart';
import 'package:alamuti/app/controller/search_avoid_update.dart';
import 'package:alamuti/app/controller/user_advertisement_controller.dart';
import 'package:alamuti/app/data/model/advertisement.dart';
import 'package:alamuti/app/data/provider/token_provider.dart';
import 'package:alamuti/app/data/provider/base_url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';

class AdvertisementProvider {
  var tokenProvider = Get.put(TokenProvider());
  List<Advertisement> advertisementFromApi = [];

  Future<void> getUserAds(BuildContext context) async {
    advertisementFromApi = [];
    var myAdvertisementController = Get.put(UserAdvertisementController());

    showLoaderDialog(context);

    var response = await tokenProvider.api
        .get(baseUrl + 'Advertisement/myalamuti/myAds')
        .whenComplete(() => Get.back());

    if (response.statusCode == 200) {
      response.data.forEach(
        (element) {
          advertisementFromApi.add(Advertisement.fromJson(element));
        },
      );
      myAdvertisementController.adsList.value = advertisementFromApi;
    } else {
      var message =
          'متاسفانه ارتباط ناموفق بود لطفا دوباره تلاش کنید یا ارتباط خود با اینترنت را بررسی کنید';
      showStatusDialog(context: context, message: message);
    }
  }

  Future<void> search(
      {required BuildContext context, required String searchInput}) async {
    advertisementFromApi = [];

    var listAdvertisementController = Get.put(ListAdvertisementController());

    if (searchInput.length == 1 || searchInput.isEmpty) {
      Get.rawSnackbar(
          messageText: Text(
            'موردی یافت نشد',
            style: TextStyle(color: Colors.white),
            textDirection: TextDirection.rtl,
          ),
          backgroundColor: Colors.black);
      return;
    }
    showLoaderDialog(context);
    var response = await tokenProvider.api
        .get(baseUrl + 'Advertisement/search/$searchInput')
        .whenComplete(() => Get.back());

    if (response.statusCode == 200) {
      response.data.forEach(
        (element) {
          advertisementFromApi.add(Advertisement.fromJson(element));
        },
      );
    } else {
      Get.defaultDialog(
        radius: 5,
        title: 'ارتباط برقرار نشد',
        barrierDismissible: true,
        titlePadding: EdgeInsets.all(20),
        titleStyle: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 16,
        ),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'مشکلی در دریافت اطلاعات به وجود آمده لطفا دوباره تلاش کنید',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    if (advertisementFromApi.length == 0) {
      Get.rawSnackbar(
          messageText: Text(
            'موردی یافت نشد',
            style: TextStyle(color: Colors.white),
            textDirection: TextDirection.rtl,
          ),
          backgroundColor: Colors.black);
      return;
    }
    listAdvertisementController.adsList.value = advertisementFromApi;
  }

  Future<void> getAll({
    required BuildContext context,
    String? adstype,
    bool isRefreshIndicator = false,
  }) async {
    advertisementFromApi = [];
    var listAdvertisementController = Get.put(ListAdvertisementController());

    var checkIsSearchController = Get.put(CheckIsSearchedController());

    if (checkIsSearchController.isSearchResult.value == true) {
      return;
    }

    Response response;

    isRefreshIndicator ? Container() : showLoaderDialog(context);

    var argument = (adstype == null || adstype.isEmpty) ? ' ' : adstype;

    response = await tokenProvider.api
        .get(
          baseUrl + 'Advertisement/filter/$argument?pageNumber=5&pageSize=6',
        )
        .whenComplete(() => isRefreshIndicator ? Get.width : Get.back());

    if (response.statusCode == 200) {
      response.data.forEach(
        (element) {
          advertisementFromApi.add(Advertisement.fromJson(element));
        },
      );
      listAdvertisementController.adsList.value = advertisementFromApi;
    } else {
      Get.defaultDialog(
        radius: 5,
        title: 'ارتباط برقرار نشد',
        barrierDismissible: true,
        titlePadding: EdgeInsets.all(20),
        titleStyle: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 16,
        ),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'مشکلی در دریافت اطلاعات به وجود آمده لطفا دوباره تلاش کنید',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 14,
            ),
          ),
        ),
      );
    }
  }

  Future<void> postAdvertisement(
      {required BuildContext context,
      required String title,
      required String description,
      required int price,
      required int area,
      required String photo1,
      required String village,
      required String photo2}) async {
    var advertisementTypeController = Get.put(AdvertisementTypeController());

    var formData = FormData.fromMap({
      'title': title,
      'description': description,
      'price': price,
      'photo1': photo1,
      'photo2': photo2,
      'area': area,
      'village': village,
      'adsType':
          advertisementTypeController.formState.value.toString().toLowerCase(),
    });
    showLoaderDialog(context);
    var response = await tokenProvider.api
        .post(
          baseUrl + 'Advertisement',
          data: formData,
        )
        .whenComplete(() => Get.back());

    if (response.statusCode == 200) {
      Get.toNamed('/myads');

      var message = 'آگهی شما با موفقیت ارسال شد و پس از تایید منتشر میشود';
      showStatusDialog(context: context, message: message);
    } else {
      var message =
          'متاسفانه ارسال ناموفق بود لطفا دوباره تلاش کنید یا ارتباط خود با اینترنت را بررسی کنید';
      showStatusDialog(context: context, message: message);
    }
  }

  Future<void> deleteAds(
      {required BuildContext context, required int id}) async {
    var myAdvertisementController = Get.put(UserAdvertisementController());

    for (int i = 0; i < myAdvertisementController.adsList.length; i++) {
      if (myAdvertisementController.adsList[i].id == id) {
        myAdvertisementController.adsList.removeAt(i);
        break;
      }
    }
    showLoaderDialog(context);
    Response response = await tokenProvider.api
        .delete(baseUrl + 'Advertisement/$id')
        .whenComplete(() => Get.back());

    if (response.statusCode == 200) {
      var message = 'آگهی با موفقیت حذف شد';
      showStatusDialog(context: context, message: message);
    } else {
      var message = 'حذف آگهی ناموفق بود لطفا دوباره تلاش کنید';
      showStatusDialog(context: context, message: message);
    }
  }

  Future<void> updateAdvertisement(
      {required BuildContext context,
      required String title,
      required int id,
      required String description,
      required int price,
      required int area,
      required String photo1,
      required String village,
      required String photo2}) async {
    var advertisementTypeController = Get.put(AdvertisementTypeController());

    var formData = FormData.fromMap({
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'photo1': photo1,
      'photo2': photo2,
      'area': area,
      'village': village,
      'adsType':
          advertisementTypeController.formState.value.toString().toLowerCase(),
    });

    showLoaderDialog(context);

    var response = await tokenProvider.api
        .put(
          baseUrl + 'Advertisement',
          data: formData,
        )
        .whenComplete(() => Get.back());

    if (response.statusCode == 200) {
      Get.toNamed('/myads');

      var message =
          'تغییرات شما با موفقیت ذخیره شدند و آگهی شما پس از بررسی مجدد منتشر میشود.';
      showStatusDialog(context: context, message: message);
    } else {
      var message =
          'متاسفانه ارسال ناموفق بود لطفا دوباره تلاش کنید یا ارتباط خود با اینترنت را بررسی کنید';
      showStatusDialog(context: context, message: message);
    }
  }

  showLoaderDialog(context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Colors.greenAccent,
          ),
        ],
      ),
    );
    showDialog(
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
      context: context,
    );
  }

  showStatusDialog({required context, required String message}) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      elevation: 0,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 15,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
              onPressed: () {
                Get.back(closeOverlays: true);
              },
              child: Text(
                'تایید',
                style: TextStyle(color: Colors.greenAccent),
              )),
        )
      ],
    );
    showDialog(
      barrierDismissible: true,
      builder: (BuildContext context) {
        return alert;
      },
      context: context,
    );
  }
}
