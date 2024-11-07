import 'package:get_storage/get_storage.dart';

mixin CacheManager {
  final box = GetStorage();

  Future<void> saveTokenRefreshToken(String token, String refreshToken) async {
    await box.write(CacheManagerKey.TOKEN.toString(), token);
    await box.write(CacheManagerKey.REFRESHTOKEN.toString(), refreshToken);
  }

  RefreshToken getTokenRefreshToken() {
    var token = box.read(CacheManagerKey.TOKEN.toString());
    var refresh = box.read(CacheManagerKey.REFRESHTOKEN.toString());
    return RefreshToken(token, refresh);
  }

  Future<void> removeTokenRefreshToken() async {
    await box.remove(CacheManagerKey.TOKEN.toString());
    await box.remove(CacheManagerKey.REFRESHTOKEN.toString());
  }

  Future<void> savePhoneNumber(String phoneNumber) async {
    await box.write(CacheManagerKey.PHONENUMBER.toString(), phoneNumber);
  }

  String getPhoneNumber() {
    return box.read(CacheManagerKey.PHONENUMBER.toString());
  }

  Future<void> saveUserId(String userId) async {
    await box.write(CacheManagerKey.USERID.toString(), userId);
  }

  String getUserId() {
    return box.read(CacheManagerKey.USERID.toString());
  }

  UserInfo getUserInfo(String phoneNumber, String password) {
    var phone = box.read(CacheManagerKey.PHONENUMBER.toString());
    var pass = box.read(CacheManagerKey.PASSWORD.toString());
    return UserInfo(phone, pass);
  }

  bool isLoggedIn() {
    var status = box.read(CacheManagerKey.AUTHENTICATED.toString());
    if (status == null) {
      return false;
    }
    return status;
  }

  Future<void> saveLogin() async {
    await box.write(CacheManagerKey.AUTHENTICATED.toString(), true);
  }

  Future<void> saveLogout() async {
    await box.write(CacheManagerKey.AUTHENTICATED.toString(), false);
  }
}

enum CacheManagerKey {
  TOKEN,
  REFRESHTOKEN,
  PHONENUMBER,
  PASSWORD,
  AUTHENTICATED,
  USERID
}

class RefreshToken {
  final String token;
  final String refreshToken;

  RefreshToken(this.token, this.refreshToken);
}

class UserInfo {
  final String phoneNumber;
  final String password;

  UserInfo(this.phoneNumber, this.password);
}
