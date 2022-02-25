import 'package:get_storage/get_storage.dart';

mixin CacheManager {
  final box = GetStorage();
  Future<void> saveTokenRefreshToken(String token, String refreshtoken) async {
    await box.write(CacheManagerKey.TOKEN.toString(), token);
    await box.write(CacheManagerKey.REFRESHTOKEN.toString(), refreshtoken);
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

  Future<String> getUserId() async {
    return await box.read(CacheManagerKey.USERID.toString());
  }

  Future<UserInfo> getUserInfo(String phoneNumber, String password) async {
    var phone = await box.read(CacheManagerKey.PHONENUMBER.toString());
    var pass = await box.read(CacheManagerKey.PASSWORD.toString());
    return UserInfo(phone, pass);
  }

  Future<bool> isLoggedIn() async {
    var status = await box.read(CacheManagerKey.AUTHENTICATED.toString());
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
  final String refreshtoken;

  RefreshToken(this.token, this.refreshtoken);
}

class UserInfo {
  final String phonenumber;
  final String password;

  UserInfo(this.phonenumber, this.password);
}
