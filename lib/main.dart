import 'package:alamuti/data/apicall/chat_message_apicall.dart';
import 'package:alamuti/data/apicall/signalr_helper.dart';
import 'package:alamuti/data/storage/cache_manager.dart';
import 'package:alamuti/feature/theme.dart';
import 'package:alamuti/feature/widgets/buttom_navbar_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pushe_flutter/pushe.dart';

import 'routes/routes.dart';

Future<void> main() async {
  await GetStorage.init();
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
