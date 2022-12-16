import 'dart:io';

import 'package:alamuti/app/data/provider/signalr_helper.dart';
import 'package:alamuti/app/routes/routes.dart';
import 'package:alamuti/app/ui/theme.dart';
import 'package:alamuti/app/ui/widgets/bottom_navbar_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pushe_flutter/pushe.dart';

Future<void> main() async {
  await GetStorage.init();
  HttpOverrides.global = new MyHttpOverrides();

  await Pushe.enableNotificationForceForegroundAware();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: routes,
      smartManagement: SmartManagement.full,
      theme: themes,
    ),
  );

  SignalRHelper signalRHelper = SignalRHelper(
      handler: () => newMessageController.haveNewMessage.value = true);

  signalRHelper.joinToGroups();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
