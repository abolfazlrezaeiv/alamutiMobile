import 'dart:async';
import 'package:alamuti/app/data/entities/login_request_model.dart';
import 'package:alamuti/app/data/entities/login_response_model.dart';
import 'package:alamuti/app/data/entities/register_request_model.dart';
import 'package:alamuti/app/data/entities/register_response_model.dart';
import 'package:alamuti/app/data/provider/base_url.dart';
import 'package:alamuti/app/data/storage/cache_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginProvider extends GetConnect with CacheManager {
  final String loginUrl = baseLoginUrl + 'login';

  final String registerUrl = baseLoginUrl + 'register';
  final Dio dio = Dio();

  Future<LoginResponseModel?> fetchLogin(
      LoginRequestModel model, BuildContext context) async {
    final response = await post(loginUrl, model.toJson());

    if (response.statusCode == 200) {
      print(response.body['token']);
      print(response.body['refreshToken']);
      return LoginResponseModel.fromJson(response.body);
    } else {
      var message = 'کد ورود اشتباه است ...';
      showStatusDialog(context: context, message: message);
      return null;
    }
  }

  Future<RegisterResponseModel?> fetchRegister(
      RegisterRequestModel model, BuildContext context) async {
    try {
      final response =
          await post(registerUrl, model.toJson()).timeout(Duration(seconds: 6));

      if (response.statusCode == 200) {
        print('sucessful');
        saveUserId(response.body['id']);
        return RegisterResponseModel.fromJson(response.body);
      } else {
        var message = 'خطا در اتصال به اینترنت ...';
        showStatusDialog(context: context, message: message);
        print('not successful');

        return null;
      }
    } on TimeoutException catch (_) {
      var message = 'خطا در اتصال به اینترنت ...';
      showStatusDialog(context: context, message: message);
      return null;
    }
  }

  showStatusDialog({required context, required String message}) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      elevation: 3,
      content: Text(
        message,
        textDirection: TextDirection.rtl,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: Get.width / 25,
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Get.back(closeOverlays: true);
            },
            child: Text(
              'تایید',
              style: TextStyle(
                color: Colors.greenAccent,
                fontWeight: FontWeight.w400,
                fontSize: Get.width / 27,
              ),
            ))
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
