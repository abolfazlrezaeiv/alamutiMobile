import 'package:get/get.dart';

class AdvertisementTypeController extends GetxController {
  final formState = AdsFormState.JOB.obs;

  void getForm(AdsFormState formstate) {
    formState.value = formstate;
  }
}

enum AdsFormState { REALSTATE, FOOD, JOB }
