import 'package:get_storage/get_storage.dart';

mixin CacheManager {
  Future<bool> saveTokenRefreshToken(String token, String refreshtoken) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.TOKEN.toString(), token);
    await box.write(CacheManagerKey.REFRESHTOKEN.toString(), refreshtoken);
    return true;
  }

  RefreshToken getTokenRefreshToken() {
    final box = GetStorage();

    var token = box.read(CacheManagerKey.TOKEN.toString());
    var refresh = box.read(CacheManagerKey.REFRESHTOKEN.toString());
    return RefreshToken(token, refresh);
  }

  Future<void> removeTokenRefreshToken() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.TOKEN.toString());
    await box.remove(CacheManagerKey.REFRESHTOKEN.toString());
  }

  Future<bool> savePhoneNumber(String phoneNumber, String password) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.PHONENUMBER.toString(), phoneNumber);
    await box.write(CacheManagerKey.PASSWORD.toString(), password);
    return true;
  }

  String getPhonenNumber() {
    final box = GetStorage();
    var phone = box.read(CacheManagerKey.PHONENUMBER.toString());
    return phone;
  }

  Future<bool> saveUserId(String userId) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.USERID.toString(), userId);

    return true;
  }

  getUserId() async {
    final box = GetStorage();
    var id = box.read(CacheManagerKey.USERID.toString());
    return id;
  }

  Future<UserInfo> getUserInfo(String phoneNumber, String password) async {
    final box = GetStorage();
    var phone = await box.read(CacheManagerKey.PHONENUMBER.toString());
    var pass = await box.read(CacheManagerKey.PASSWORD.toString());
    return UserInfo(phone, pass);
  }

  Future<bool> isLoggedIn() async {
    final box = GetStorage();

    var status = await box.read(CacheManagerKey.ISLOGGEDIN.toString());
    if (status == null) {
      return false;
    }
    return status;
  }

  Future<void> saveLogin() async {
    final box = GetStorage();
    await box.write(CacheManagerKey.ISLOGGEDIN.toString(), true);
  }

  Future<void> saveLogout() async {
    final box = GetStorage();
    await box.write(CacheManagerKey.ISLOGGEDIN.toString(), false);
  }
}

enum CacheManagerKey {
  TOKEN,
  REFRESHTOKEN,
  PHONENUMBER,
  PASSWORD,
  ISLOGGEDIN,
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
