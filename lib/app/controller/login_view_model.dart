import 'package:alamuti/app/data/model/login_request_model.dart';
import 'package:alamuti/app/data/model/login_response_model.dart';
import 'package:alamuti/app/data/model/register_request_model.dart';
import 'package:alamuti/app/data/provider/login_provider.dart';
import 'package:alamuti/app/ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'authentication_manager.dart';

class LoginViewModel extends GetxController {
  late final LoginProvider _loginProvider;
  late final AuthenticationManager _authManager;

  @override
  void onInit() {
    super.onInit();
    _loginProvider = Get.put(LoginProvider());
    _authManager = Get.find();
  }

  Future<bool> loginUser(String password) async {
    final response =
        await _loginProvider.fetchLogin(LoginRequestModel(password: password));

    if (response != null) {
      /// Set isLogin to true
      if (response.success == true) {
        _authManager.login(response.token!, response.refreshtoken!);
      }

      return true;
    } else {
      /// Show user a dialog about the error response
      Get.defaultDialog(
          title: 'ورود ناموفق',
          textConfirm: 'اصلاح رمز',
          // backgroundColor: Color.fromRGBO(141, 235, 172, 1),
          backgroundColor: Colors.white,
          middleText: 'لطفا کد پیامک شده را با دقت وارد کنید',
          onConfirm: () {
            Get.back();
          },
          radius: 5);
      return false;
    }
  }

  Future<void> registerUser(String phone) async {
    final response = await _loginProvider
        .fetchRegister(RegisterRequestModel(phonenumber: phone));

    if (response != null) {
      /// Set isLogin to true

    } else {
      print('failed');

      /// Show user a dialog about the error response
      Get.defaultDialog(
          middleText: 'Register Error',
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          });
    }
  }
}
