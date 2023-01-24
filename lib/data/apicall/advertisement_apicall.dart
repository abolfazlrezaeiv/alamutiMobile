import 'dart:async';
import 'dart:convert';

import 'package:alamuti/controller/ads_form_controller.dart';
import 'package:alamuti/controller/detail_page_advertisement.dart';
import 'package:alamuti/data/apicall/base_url.dart';
import 'package:alamuti/data/apicall/refresh_token_apicall.dart';
import 'package:alamuti/data/entities/advertisement.dart';
import 'package:alamuti/data/entities/list_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';

class AdvertisementAPICall {
  final RefreshTokenApiCall tokenProvider = Get.put(RefreshTokenApiCall());

  List<Advertisement> advertisementFromApi = [];

  Future<void> getDetails({required int id}) async {
    final DetailPageController detailPageController =
        Get.put(DetailPageController());

    var response = await tokenProvider.api
        .get(baseUrl + 'Advertisement/$id')
        .whenComplete(() => Get.back());

    if (response.statusCode == 200) {
      detailPageController.details.value = [
        Advertisement.fromJson(response.data)
      ];
    } else {
      var message = 'متاسفانه ارتباط ناموفق بود لطفا دوباره امتحان کنید';
/*
      Alert.showStatusDialog(context: context, message: message);
*/
    }
  }

  Future<ListPage<Advertisement>> getAll(
      {int number = 1, int size = 8, String? category}) async {
    advertisementFromApi = [];

    Response response;

    var argument = (category == null || category.isEmpty) ? ' ' : category;

    try {
      response = await tokenProvider.api
          .get(baseUrl +
              'Advertisement/filter/$argument?pageNumber=$number&pageSize=$size')
          .timeout(Duration(seconds: 14));

      var xPagination = jsonDecode(response.headers['X-Pagination']![0]);
      print(xPagination);

      if (response.statusCode == 200) {
        response.data.forEach(
          (element) {
            advertisementFromApi.add(Advertisement.fromJson(element));
          },
        );

        return ListPage(
            itemList: advertisementFromApi,
            grandTotalCount: xPagination['TotalCount']);
      } else {
        return ListPage(
            itemList: advertisementFromApi,
            grandTotalCount: xPagination['TotalCount']);
      }
    } on TimeoutException catch (_) {
      throw TimeoutException('');
    }
  }

  Future<ListPage<Advertisement>> search(
      {int number = 1, int size = 10, required String searchInput}) async {
    advertisementFromApi = [];
    try {
      var response = await tokenProvider.api
          .get(baseUrl +
              'Advertisement/search/$searchInput?pageNumber=$number&pageSize=$size')
          .timeout(Duration(seconds: 4));

      var xPagination = jsonDecode(response.headers['X-Pagination']![0]);
      print(xPagination);

      if (response.statusCode == 200) {
        response.data.forEach(
          (element) {
            advertisementFromApi.add(Advertisement.fromJson(element));
          },
        );
        return ListPage(
            itemList: advertisementFromApi,
            grandTotalCount: xPagination['TotalCount']);
      } else {
        return ListPage(
            itemList: advertisementFromApi,
            grandTotalCount: xPagination['TotalCount']);
      }
    } on TimeoutException catch (_) {
      throw TimeoutException('');
    }
  }

  Future<ListPage<Advertisement>> getUserAds({
    int number = 1,
    int size = 10,
  }) async {
    advertisementFromApi = [];
    try {
      var response = await tokenProvider.api
          .get(baseUrl +
              'Advertisement/useradvertisement?PageNumber=$number&PageSize=$size')
          .timeout(Duration(seconds: 12));
      print(response.data);
      var xPagination = jsonDecode(response.headers['X-Pagination']![0]);
      print(xPagination);
      //
      // if (response.statusCode == 200) {
      response.data.forEach(
        (element) {
          advertisementFromApi.add(Advertisement.fromJson(element));
        },
      );
      return ListPage(
          itemList: advertisementFromApi,
          grandTotalCount: xPagination['TotalCount']);
      // } else {
      //   return ListPage(
      //       itemList: advertisementFromApi,
      //       grandTotalCount: xPagination['TotalCount']);
      // }
    } on TimeoutException catch (_) {
      throw TimeoutException('');
    }
  }

  Future<void> postAdvertisement(
      {required String title,
      required String description,
      required int price,
      required int area,
      required String listviewPhoto,
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
      'listViewPhoto': listviewPhoto,
      'area': area,
      'village': village,
      'adsType':
          advertisementTypeController.formState.value.toString().toLowerCase(),
    });

    var response = await tokenProvider.api
        .post(
          baseUrl + 'Advertisement',
          data: formData,
        )
        .whenComplete(() => Get.back());

    if (response.statusCode == 200) {
      Get.offNamed('/myads');

      var message = 'آگهی شما با موفقیت ارسال شد و پس از تایید منتشر خواهد شد';

      /* Alert.showStatusDialog(context: context, message: message);*/
    } else {
      /* var message = 'متاسفانه ارتباط ناموفق بود لطفا دوباره امتحان کنید';
      Alert.showStatusDialog(context: context, message: message);*/
    }
  }

  Future<void> deleteAds({required int id}) async {
    Response response = await tokenProvider.api
        .delete('https://alamuti.ir/api/advertisement/$id')
        .timeout(Duration(seconds: 5))
        .whenComplete(() => Get.back());
    print(response.statusCode);
    print(response.statusMessage);
    if (response.statusCode == 200) {
      var message = 'آگهی با موفقیت حذف شد';
/*
      Alert.showStatusDialog(context: context, message: message);
*/
    } else {
      /* var message = 'حذف آگهی ناموفق بود لطفا دوباره تلاش کنید';
      Alert.showStatusDialog(context: context, message: message);*/
    }
  }

  Future<void> updateAdvertisement(
      {required String title,
      required int id,
      required String description,
      required int price,
      required int area,
      required String photo1,
      required String listviewPhoto,
      required String village,
      required String photo2}) async {
    var advertisementTypeController = Get.put(AdvertisementTypeController());

    var formData = FormData.fromMap({
      'id': id,
      'title': title,
      'description': description,
      'listViewPhoto': listviewPhoto,
      'price': price,
      'photo1': photo1,
      'photo2': photo2,
      'area': area,
      'village': village,
      'adsType':
          advertisementTypeController.formState.value.toString().toLowerCase(),
    });

    var response = await tokenProvider.api
        .put(
          baseUrl + 'Advertisement',
          data: formData,
        )
        .whenComplete(() => Get.back());

    if (response.statusCode == 200) {
      Get.toNamed('/myads');

      var message =
          'تغییرات شما با موفقیت ذخیره شدند و آگهی شما پس از بررسی مجدد منتشر خواهد شد.';
/*
      Alert.showStatusDialog(context: context, message: message);
*/
    } else {
      /*  var message = 'متاسفانه ارتباط ناموفق بود لطفا دوباره امتحان کنید';
      Alert.showStatusDialog(context: context, message: message);*/
    }
  }

  Future<void> sendReport({
    required int id,
    required String report,
  }) async {
    var formData = FormData.fromMap({
      'id': id,
      'message': report,
    });

    var response = await tokenProvider.api.put(
      baseUrl + 'Advertisement/report',
      data: formData,
    );

    if (response.statusCode == 200) {
      var message =
          'باتشکر از گزارش شما. کارشناسان ما در اسرع وقت به مشکل رسیدگی می کنند.';
      /*Alert.showStatusDialog(context: context, message: message);*/
    } else {
      /*   var message = 'ارتباط ناموفق بود لطفا دوباره امتحان کنید';
      Alert.showStatusDialog(context: context, message: message);*/
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
}
