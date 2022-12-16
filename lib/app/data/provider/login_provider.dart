import 'dart:async';
import 'dart:convert';

import 'package:alamuti/app/data/entities/login_request_model.dart';
import 'package:alamuti/app/data/entities/login_response_model.dart';
import 'package:alamuti/app/data/entities/register_request_model.dart';
import 'package:alamuti/app/data/entities/auth_byphone_response.dart';
import 'package:alamuti/app/data/provider/base_url.dart';
import 'package:alamuti/app/data/storage/cache_manager.dart';
import 'package:alamuti/app/ui/alert_dialog_class.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pushe_flutter/pushe.dart';

class LoginProvider with CacheManager {
  var isLogged = false;

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

  Future<AuthenticationByPhoneResponse> authenticateByPhoneNumber(
      AuthByPhoneNumberRequestModel model) async {
    try {
      var url = Uri.parse('$baseUrl/api/auth/authenticate');
      var response = await http.post(
        url,
        body: jsonEncode(model),
      );
      var userdata =
          AuthenticationByPhoneResponse.fromJson(jsonDecode(response.body));
      // await saveUserId(userdata.);
      // await savePhoneNumber(body['phonenumber']);

      Pushe.setCustomId(getUserId());

      // return AuthenticationByPhoneResponse.fromJson(body);
      return AuthenticationByPhoneResponse(phonenumber: '', userId: '');
    } catch (error) {
      return AuthenticationByPhoneResponse(phonenumber: '', userId: '');
    }
  }

  void logOut() {
    isLogged = false;
    saveLogout();
    removeTokenRefreshToken();
  }

  void login(String token, String refreshtoken) async {
    isLogged = true;
    await saveTokenRefreshToken(token, refreshtoken);
    await saveLogin();
  }

  checkLoginStatus() async {
    var loginStatus = isLoggedIn();
    return loginStatus;
  }
}
