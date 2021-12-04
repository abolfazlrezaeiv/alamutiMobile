import 'package:get_storage/get_storage.dart';

mixin CacheManager {
  Future<bool> saveTokenRefreshToken(
      String? token, String? refreshtoken) async {
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

  Future<UserInfo> getUserInfo(String phoneNumber, String password) async {
    final box = GetStorage();
    var phone = await box.read(CacheManagerKey.PHONENUMBER.toString());
    var pass = await box.read(CacheManagerKey.PASSWORD.toString());
    return UserInfo(phone, pass);
  }
}

enum CacheManagerKey { TOKEN, REFRESHTOKEN, PHONENUMBER, PASSWORD }

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
