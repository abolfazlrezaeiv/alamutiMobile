import 'dart:async';
import 'dart:convert';
import 'package:alamuti/app/data/entities/login_request_model.dart';
import 'package:alamuti/app/data/entities/login_response_model.dart';
import 'package:alamuti/app/data/entities/register_request_model.dart';
import 'package:alamuti/app/data/entities/register_response_model.dart';
import 'package:alamuti/app/data/provider/base_url.dart';
import 'package:alamuti/app/data/storage/cache_manager.dart';
import 'package:alamuti/app/ui/alert_dialog_class.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pushe_flutter/pushe.dart';

class LoginProvider with CacheManager {
  Future<LoginResponseModel?> fetchLogin(
      LoginRequestModel model, BuildContext context) async {
    var url = Uri.parse(baseAuthUrl + '/login');

    var response = await http.post(
      url,
      body: jsonEncode(model),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
    );

    var body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print(body['token']);
      print(body['refreshToken']);

      return LoginResponseModel.fromJson(body);
    } else {
      var message = 'کد ورود اشتباه است ...';
      Alert.showNoConnectionDialog(context: context, message: message);

      return null;
    }
  }

  Future<RegisterResponseModel?> fetchRegister(
      RegisterRequestModel model, BuildContext context) async {
    try {
      var url = Uri.parse(baseAuthUrl + '/Authenticate');

      var response = await http.post(
        url,
        body: jsonEncode(model),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
      );

      var body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('successful');

        await saveUserId(body['id']);
        await savePhoneNumber(body['phonenumber']);

        Pushe.setCustomId(await getUserId());

        return RegisterResponseModel.fromJson(body);
      } else {
        var message = 'خطا در اتصال به اینترنت ...';
        Alert.showNoConnectionDialog(context: context, message: message);
        print('not successful');

        return null;
      }
    } on TimeoutException catch (_) {
      var message = 'خطا در اتصال به اینترنت ...';

      Alert.showNoConnectionDialog(context: context, message: message);

      return null;
    }
  }
}
