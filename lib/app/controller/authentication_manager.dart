import 'package:alamuti/app/data/storage/cachemanager.dart';
import 'package:get/get.dart';

class AuthenticationManager extends GetxController with CacheManager {
  final isLogged = false.obs;

  void logOut() {
    isLogged.value = false;
    saveLogout();
    removeTokenRefreshToken();
  }

  void login(String token, String refreshtoken) async {
    isLogged.value = true;
    //Token is cached
    await saveTokenRefreshToken(token, refreshtoken);
    await saveLogin();
  }

  checkLoginStatus() {
    var loginStatus = isLoggedIn();
    return loginStatus;
  }
}
