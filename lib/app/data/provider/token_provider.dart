import 'package:alamuti/app/controller/authentication_manager_controller.dart';
import 'package:alamuti/app/data/provider/base_url.dart';
import 'package:alamuti/app/data/storage/cache_manager.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

class TokenProvider extends GetxController with CacheManager {
  var api = Dio();
  AuthenticationManager authenticationManager =
      Get.put(AuthenticationManager());
  var token;
  var refreshtoken;

  Future<Response> refreshToken() async {
    var tokenAndRefresh = getTokenRefreshToken();
    refreshtoken = tokenAndRefresh.refreshToken;
    token = tokenAndRefresh.token;

    final response = await this.api.post(baseAuthUrl + 'RefreshToken', data: {
      'token': token.toString(),
      'refreshToken': refreshtoken.toString()
    });
    if (response.statusCode == 200) {
      if (response.data['token'] != null) {
        saveTokenRefreshToken(
            response.data['token'], response.data['refreshToken']);
        print("access token" + response.data['token']);
        print("refresh token" + response.data['refreshToken']);
        return response;
      }
      return response;
    } else {
      print(response.data['errors']);
      print(response.statusCode);
      authenticationManager.logOut();
      return response;
    }
  }

  TokenProvider() {
    this.api.interceptors.add(
          InterceptorsWrapper(
            onRequest: (request, handler) {
              if (token != null && token != '')
                request.headers['Authorization'] = 'Bearer $token';
              return handler.next(request);
            },
            onError: (e, handler) async {
              if (e.response?.statusCode == 401) {
                try {
                  var refreshTokenResponse = await refreshToken();
                  if (refreshTokenResponse.statusCode == 200) {
                    //get new tokens ...
                    print("access token" + token);
                    print("refresh token" + refreshtoken);
                    //set bearer
                    e.requestOptions.headers["Authorization"] =
                        "Bearer " + token;
                    //create request with new access token
                    final opts = new Options(
                        method: e.requestOptions.method,
                        headers: e.requestOptions.headers);
                    final cloneReq = await api.request(e.requestOptions.path,
                        options: opts,
                        data: e.requestOptions.data,
                        queryParameters: e.requestOptions.queryParameters);
                    print(
                        'ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd');
                    return handler.resolve(cloneReq);
                  }
                  return handler.next(e);
                } catch (e, _) {}
              }
            },
          ),
        );
  }
}
