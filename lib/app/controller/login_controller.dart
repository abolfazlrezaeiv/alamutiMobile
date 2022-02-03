import 'package:alamuti/app/data/entities/login_request_model.dart';
import 'package:alamuti/app/data/entities/register_request_model.dart';
import 'package:alamuti/app/data/provider/login_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'authentication_manager_controller.dart';

class LoginViewModel extends GetxController {
  late final LoginProvider _loginProvider;
  late final AuthenticationManager _authManager;

  @override
  void onInit() {
    super.onInit();
    _loginProvider = Get.put(LoginProvider());
    _authManager = Get.find();
  }

  Future<bool> loginUser(String password, BuildContext context) async {
    final response = await _loginProvider.fetchLogin(
        LoginRequestModel(password: password), context);

    if (response != null) {
      if (response.success == true) {
        _authManager.login(response.token!, response.refreshtoken!);
      }
      return true;
    }
    return false;
  }

  Future<bool> registerUser(String phone, BuildContext context) async {
    final response = await _loginProvider.fetchRegister(
        RegisterRequestModel(phonenumber: phone), context);

    if (response != null) {
      return true;
    }
    return false;
  }
}
