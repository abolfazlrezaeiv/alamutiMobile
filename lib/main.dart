import 'dart:io';
import 'package:alamuti/app/data/provider/chat_message_provider.dart';
import 'package:alamuti/app/data/provider/signalr_helper.dart';
import 'package:alamuti/app/data/storage/cache_manager.dart';
import 'package:alamuti/app/routes/routes.dart';
import 'package:alamuti/app/ui/theme.dart';
import 'package:alamuti/app/ui/widgets/buttom_navbar_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pushe_flutter/pushe.dart';

Future<void> main() async {
  await GetStorage.init();
  HttpOverrides.global = new MyHttpOverrides();
  var messageProvider = MessageProvider();

  await Pushe.enableNotificationForceForegroundAware();

  var storage = GetStorage();

  runApp(Application());

  SignalRHelper signalRHelper = SignalRHelper(handler: () {
    newMessageController.haveNewMessage.value = true;
  });

  var chats = await messageProvider.getGroupsNoPagination();

  chats.forEach((chat) async => {
        await signalRHelper.joinToGroup(chat.name),
        if (chat.isChecked == false &&
            chat.lastMessage.sender !=
                storage.read(
                  CacheManagerKey.USERID.toString(),
                ))
          {newMessageController.haveNewMessage.value = true}
      });
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: routes,
      smartManagement: SmartManagement.full,
      theme: themes,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
