import 'package:alamuti/app/data/provider/chat_message_provider.dart';
import 'package:alamuti/app/data/provider/signalr_helper.dart';
import 'package:alamuti/app/routes/routes.dart';
import 'package:alamuti/app/ui/theme.dart';
import 'package:alamuti/app/ui/widgets/buttom_navbar_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  await GetStorage.init();

  var messageProvider = MessageProvider();

  SignalRHelper signalRHelper = SignalRHelper(handler: () {
    newMessageController.haveNewMessage.value = true;
  });

  var chats = await messageProvider.getGroupsNoPagination();

  chats.forEach((group) async => await signalRHelper.joinToGroup(group.name));

  runApp(Application());
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
