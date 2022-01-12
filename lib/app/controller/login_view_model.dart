import 'package:alamuti/app/data/model/login_request_model.dart';
import 'package:alamuti/app/data/model/register_request_model.dart';
import 'package:alamuti/app/data/provider/login_provider.dart';
import 'package:get/get.dart';

import 'authentication_manager.dart';

class LoginViewModel extends GetxController {
  late final LoginProvider _loginProvider;
  late final AuthenticationManager _authManager;

  @override
  void onInit() {
    super.onInit();
    _loginProvider = Get.put(LoginProvider());
    _authManager = Get.find();
  }

  @override
  void dispose() {
    Get.delete<LoginProvider>();
    super.dispose();
  }

  Future<bool> loginUser(String password) async {
    final response =
        await _loginProvider.fetchLogin(LoginRequestModel(password: password));

    if (response != null) {
      if (response.success == true) {
        _authManager.login(response.token!, response.refreshtoken!);
      }

      return true;
    } else {
      return false;
    }
  }

  Future<bool> registerUser(String phone) async {
    final response = await _loginProvider
        .fetchRegister(RegisterRequestModel(phonenumber: phone));

    if (response != null) {
      return true;
    } else {
      return false;
    }
  }
}
