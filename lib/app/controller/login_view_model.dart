import 'package:alamuti/app/data/model/login_request_model.dart';
import 'package:alamuti/app/data/model/register_request_model.dart';
import 'package:alamuti/app/data/provider/login_provider.dart';
import 'package:alamuti/app/ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

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

  Future<void> loginUser(String password) async {
    final response =
        await _loginProvider.fetchLogin(LoginRequestModel(password: password));

    if (response != null) {
      /// Set isLogin to true
      _authManager.login(response.token!, response.refreshtoken!);
      Get.to(HomePage());
    } else {
      /// Show user a dialog about the error response
      Get.defaultDialog(
          middleText: 'User not found!',
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          });
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
