import 'package:alamuti/app/data/entities/login_request_model.dart';
import 'package:alamuti/app/data/entities/login_response_model.dart';
import 'package:alamuti/app/data/entities/register_request_model.dart';
import 'package:alamuti/app/data/entities/register_response_model.dart';
import 'package:alamuti/app/data/provider/base_url.dart';
import 'package:alamuti/app/data/storage/cache_manager.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class LoginProvider extends GetConnect with CacheManager {
  final String loginUrl = baseLoginUrl + 'login';

  final String registerUrl = baseLoginUrl + 'register';
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
      saveUserId(response.body['id']);
      return RegisterResponseModel.fromJson(response.body);
    } else {
      print('not successful');

      return null;
    }
  }
}
