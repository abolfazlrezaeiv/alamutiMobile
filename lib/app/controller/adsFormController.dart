import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AdsFormController extends GetxController {
  final formState = AdsFormState.JOB.obs;

  void getForm(AdsFormState formstate) {
    formState.value = formstate;
  }

  // void login(String token, String refreshtoken) async {
  //   isLogged.value = true;
  //   //Token is cached
  //   await saveTokenRefreshToken(token, refreshtoken);
  //   await saveLogin();
  // }

  // checkLoginStatus() {
  //   var loginStatus = isLoggedIn();
  //   return loginStatus;
  // }
}

enum AdsFormState { REALSTATE, FOOD, JOB }
