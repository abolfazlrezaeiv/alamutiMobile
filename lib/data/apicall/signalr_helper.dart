import 'package:alamuti/controller/new_message_controller.dart';
import 'package:alamuti/data/apicall/base_url.dart';
import 'package:alamuti/data/storage/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:signalr_core/signalr_core.dart';

class SignalRHelper with CacheManager {
  late HubConnection connection;

  NewMessageController newMessageController = Get.put(NewMessageController());

  GetStorage storage = GetStorage();

  VoidCallback handler;

  SignalRHelper({required this.handler}) {
    connection = HubConnectionBuilder()
        .withUrl(baseLoginUrl + 'chat', HttpConnectionOptions())
        .withAutomaticReconnect()
        .build();

    connection.start()?.whenComplete(() => connection
        .invoke('JoinToGroup',
            args: [storage.read(CacheManagerKey.USERID.toString())])
        .whenComplete(() => connection.on("InitializeChat", (arguments) {
              // newMessageController.haveNewMessage.value = true;
              print('on initialize called');
              // handler();
            }))
        .whenComplete(() => connection.on("ReceiveMessage", (arguments) async {
              if (arguments![1] !=
                  await storage.read(CacheManagerKey.USERID.toString())) {
                newMessageController.haveNewMessage.value = true;
              }
              print('on recivee called');

              handler();
            })));
  }

  sendMessage(
      {required String receiverId,
      required String senderId,
      required String message,
      required String grouptitle,
      String? groupname,
      String? groupImage}) async {
    await connection.invoke('SendMessage', args: [
      receiverId,
      senderId,
      message,
      groupname,
      grouptitle,
      groupImage
    ]);
  }

  Future<void> initializeChat(
      {required String receiverId,
      required String senderId,
      required String grouptitle,
      required String groupname,
      String? groupImage}) async {
    await connection.invoke('InitializeChat',
        args: [receiverId, senderId, groupname, grouptitle, groupImage]);
  }

  joinToGroup(String userId) async {
    await connection.invoke('JoinToGroup', args: [userId]);
  }

  leaveGroup(String groupname) async {
    await connection.invoke('LeaveGroup', args: [groupname]);
  }
}
