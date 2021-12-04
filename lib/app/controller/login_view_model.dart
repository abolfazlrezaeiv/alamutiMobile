import 'package:alamuti/app/data/model/login_request_model.dart';
import 'package:alamuti/app/data/model/register_request_model.dart';
import 'package:alamuti/app/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'authentication_manager.dart';

class LoginViewModel extends GetxController {
  late final LoginService _loginService;
  late final AuthenticationManager _authManager;

  @override
  void onInit() {
    super.onInit();
    _loginService = Get.put(LoginService());
    _authManager = Get.find();
  }

  Future<void> loginUser(String phone, String password) async {
    final response = await _loginService
        .fetchLogin(LoginRequestModel(phone: phone, password: password));

    if (response != null) {
      /// Set isLogin to true
      _authManager.login(response.token, response.refreshtoken);
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

  Future<void> registerUser(String phone, String password) async {
    final response = await _loginService
        .fetchRegister(RegisterRequestModel(phonenumber: phone));

    if (response != null) {
      /// Set isLogin to true

    } else {
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
