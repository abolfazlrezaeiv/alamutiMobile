import 'package:get/get.dart';

class AdvertisementTypeController extends GetxController {
  final formState = AdsFormState.JOB.obs;
}

enum AdsFormState { REALSTATE, FOOD, JOB, Trap }
