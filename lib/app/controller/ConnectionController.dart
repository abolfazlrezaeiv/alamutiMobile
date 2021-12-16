import 'dart:io';

import 'package:get/get.dart';

class ConnectionController extends GetxController {
  final isConnected = true.obs;

  checkConnectionStatus() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        isConnected.value = true;
      }
    } on SocketException catch (_) {
      isConnected.value = false;
    }
  }
}
