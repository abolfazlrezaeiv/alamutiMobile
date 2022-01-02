import 'package:alamuti/app/data/storage/cachemanager.dart';
import 'package:alamuti/app/ui/home/home_page.dart';
import 'package:get/get.dart';

class ChatTargetUserController extends GetxController {
  final userId = ''.obs;

  void saveUserId(String userid) {
    userId.value = userid;
  }
}
