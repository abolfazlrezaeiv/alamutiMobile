import 'package:alamuti/data/datasources/storage/cache_manager.dart';
import 'package:get/get.dart';

class AuthenticationManager extends GetxController with CacheManager {
  final isLogged = false.obs;

  void logOut() {
    isLogged.value = false;
    saveLogout();
    removeTokenRefreshToken();
    Get.offAllNamed('/register');
  }

  void login(String token, String refreshtoken) async {
    isLogged.value = true;
    await saveTokenRefreshToken(token, refreshtoken);
    await saveLogin();
  }

  checkLoginStatus() async {
    var loginStatus = await isLoggedIn();
    return loginStatus;
  }
}
