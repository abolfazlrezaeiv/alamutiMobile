import 'package:alamuti/app/data/storage/cachemanager.dart';
import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:get_storage/get_storage.dart';

class TokenProvider with CacheManager {
  var api = Dio();

  var token;
  var refreshtoken;

  getAdvertisements() async {
    final response = await api.get(
      'http://192.168.162.107:5114/api/Advertisement',
      options: Options(headers: {
        "authorization": 'Bearer ' + getAccessToken(),
      }),
    );

    if (response.statusCode == HttpStatus.ok) {
      print('successfull advertisement reqquest');
    }
  }

  String getAccessToken() {
    var tokentoperint = GetStorage().read(CacheManagerKey.TOKEN.toString());

    return tokentoperint;
  }

  var _storage = GetStorage();
  Future<void> refreshToken() async {
    refreshtoken =
        await this._storage.read(CacheManagerKey.REFRESHTOKEN.toString());
    token = await this._storage.read(CacheManagerKey.TOKEN.toString());

    final response = await this
        .api
        .post('http://192.168.162.107:5114/RefreshToken', data: {
      'token': token.toString(),
      'refreshToken': refreshtoken.toString()
    });

    if (response.statusCode == 200 && response.data['token'] != null) {
      saveTokenRefreshToken(
          response.data['token'], response.data['refreshToken']);
      var newtoken = response.data['token'];
      print(newtoken);
      print('new tokens saved');
    } else {}
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = new Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return this.api.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  TokenProvider() {
    this.api.interceptors.add(
      InterceptorsWrapper(
        onError: (error, err) async {
          if (error.response?.statusCode == 403 ||
              error.response?.statusCode == 401) {
            await refreshToken();
            await _retry(error.requestOptions);
          }
        },
      ),
    );
  }
}
