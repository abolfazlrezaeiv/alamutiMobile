import 'dart:async';
import 'dart:convert';

import 'package:alamuti/data/datasources/apicalls/base_url.dart';
import 'package:alamuti/data/datasources/apicalls/refresh_token_apicall.dart';
import 'package:alamuti/data/entities/advertisement/advertisement.dart';
import 'package:alamuti/data/entities/advertisement/advertisement_list.dart';
import 'package:alamuti/data/entities/list_page.dart';
import 'package:alamuti/domain/controller/ads_form_controller.dart';
import 'package:alamuti/domain/controller/detail_page_advertisement.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';
import 'package:http/http.dart' as http;

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
    } else {}
  }

  Future<ListPage<Advertisement>> getAll(
      {int number = 1, required int size, String? category}) async {
    var argument = (category == null || category.isEmpty) ? ' ' : category;
    try {
      final response = await http.get(Uri.parse(
          'http://alamuty.ir/api/advertisement/all/$argument?pageNumber=$number&pageSize=$size'));
      print('api got called');
      print(response.body);
      var paginationHeader = jsonDecode(response.headers['pagination']!);
      print(paginationHeader);
      var responseBody = jsonDecode(response.body);
      var advertisements =
          AdvertisementListResponse.fromJson({'advertisements': responseBody});

      return ListPage<Advertisement>(
          itemList: advertisements.advertisements,
          totalPages: paginationHeader['TotalPages']);
    } on Exception catch (err) {
      throw Exception(err);
    }
  }

  Future<ListPage<Advertisement>> search(
      {int number = 1, int size = 10, required String searchInput}) async {
    advertisementFromApi = [];
    try {
      var response = await tokenProvider.api
          .get(
              'http://alamuty.ir/api/advertisement/search/$searchInput?pageNumber=$number&pageSize=$size')
          .timeout(Duration(seconds: 4));

      var xPagination = jsonDecode(response.headers['Pagination']![0]);
      print(xPagination);

      if (response.statusCode == 200) {
        response.data.forEach(
          (element) {
            advertisementFromApi.add(Advertisement.fromJson(element));
          },
        );
        return ListPage<Advertisement>(
            itemList: advertisementFromApi,
            totalPages: xPagination['TotalCount']);
      } else {
        return ListPage(
            itemList: advertisementFromApi,
            totalPages: xPagination['TotalCount']);
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
      return ListPage<Advertisement>(
          itemList: advertisementFromApi,
          totalPages: xPagination['TotalCount']);
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
    } else {}
  }

  Future<void> deleteAds({required int id}) async {
    Response response = await tokenProvider.api
        .delete('https://alamuti.ir/api/advertisement/$id')
        .timeout(Duration(seconds: 5))
        .whenComplete(() => Get.back());
    print(response.statusCode);
    print(response.statusMessage);
    if (response.statusCode == 200) {
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
    } else {}
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
    } else {}
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
