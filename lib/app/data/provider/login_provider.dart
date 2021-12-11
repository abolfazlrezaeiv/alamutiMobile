import 'package:alamuti/app/data/model/login_request_model.dart';
import 'package:alamuti/app/data/model/login_response_model.dart';
import 'package:alamuti/app/data/model/register_request_model.dart';
import 'package:alamuti/app/data/model/register_response_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class LoginProvider extends GetConnect {
  final String loginUrl = 'http://192.168.1.102:5113/login';

  final String registerUrl = 'http://192.168.1.102:5113/register';
  final Dio dio = Dio();

  Future<LoginResponseModel?> fetchLogin(LoginRequestModel model) async {
    final response = await post(loginUrl, model.toJson());

    if (response.statusCode == HttpStatus.ok) {
      print(response.body['token']);
      print(response.body['refreshToken']);
      return LoginResponseModel.fromJson(response.body);
    } else {
      return null;
    }
  }

  Future<RegisterResponseModel?> fetchRegister(
      RegisterRequestModel model) async {
    final response = await post(registerUrl, model.toJson());

    if (response.statusCode == HttpStatus.ok) {
      print('sucessful');
      return RegisterResponseModel.fromJson(response.body);
    } else {
      print(response.statusText);
      print('not successful');

      return null;
    }
  }
}
