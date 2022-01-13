import 'package:alamuti/app/data/provider/signalr_helper.dart';
import 'package:alamuti/app/data/storage/cache_manager.dart';
import 'package:alamuti/app/routes/routes.dart';
import 'package:alamuti/app/ui/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  await GetStorage.init();
  var box = GetStorage();
  if (await box.read(CacheManagerKey.ISLOGGEDIN.toString()) == true) {
    final SignalRHelper signalHelper = SignalRHelper();
    await signalHelper.initiateConnection();
    await signalHelper.reciveMessage();
    await signalHelper.createGroup(
      await box.read(CacheManagerKey.USERID.toString()),
    );
  }

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
