import 'dart:html';

import 'package:alamuti/app/data/model/login_request_model.dart';
import 'package:alamuti/app/data/model/login_response_model.dart';
import 'package:alamuti/app/data/model/register_request_model.dart';
import 'package:alamuti/app/data/model/register_response_model.dart';
import 'package:get/get.dart';

class LoginService extends GetConnect {
  final String loginUrl = 'https://localhost:44337/login';
  final String registerUrl = 'https://localhost:44337/register';

  Future<LoginResponseModel?> fetchLogin(LoginRequestModel model) async {
    final response = await post(loginUrl, model.toJson());

    if (response.statusCode == HttpStatus.ok) {
      return LoginResponseModel.fromJson(response.body);
    } else {
      return null;
    }
  }

  Future<RegisterResponseModel?> fetchRegister(
      RegisterRequestModel model) async {
    final response = await post(registerUrl, model.toJson());

    if (response.statusCode == HttpStatus.ok) {
      return RegisterResponseModel.fromJson(response.body);
    } else {
      return null;
    }
  }
}
