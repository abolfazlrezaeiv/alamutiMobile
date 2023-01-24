import 'package:alamuti/data/apicall/base_url.dart';
import 'package:alamuti/data/storage/cache_manager.dart';
import 'package:dio/dio.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

class RefreshTokenApiCall extends GetxController with CacheManager {
  var api = Dio();

  var token;
  var refreshtoken;

  var _storage = GetStorage();

  Future<Response> refreshToken() async {
    refreshtoken =
        await this._storage.read(CacheManagerKey.REFRESHTOKEN.toString());
    token = await this._storage.read(CacheManagerKey.TOKEN.toString());

    final response = await this.api.post(baseLoginUrl + 'RefreshToken', data: {
      'token': token.toString(),
      'refreshToken': refreshtoken.toString()
    });

    if (response.statusCode == 200) {
      if (response.data['token'] != null) {
        saveTokenRefreshToken(
          response.data['token'],
          response.data['refreshToken'],
        );
        print("access token" + response.data['token']);
        print("refresh token" + response.data['refreshToken']);

        return response;
      }
      return response;
    } else {
      print(response.data['errors']);
      print(response.statusCode);
      return response;
    }
  }

  RefreshTokenApiCall() {
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
                  var refreshtokenResponse = await refreshToken();
                  if (refreshtokenResponse.statusCode == 200) {
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
