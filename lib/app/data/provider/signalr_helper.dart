import 'package:alamuti/app/controller/new_message_controller.dart';
import 'package:alamuti/app/data/provider/base_url.dart';
import 'package:alamuti/app/data/storage/cache_manager.dart';
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
        .withUrl(baseChatUrl,HttpConnectionOptions())
        .withAutomaticReconnect()
        .build();

    connection.start()?.whenComplete(() => connection
        .invoke('JoinToGroup',
            args: [storage.read(CacheManagerKey.USERID.toString())])
        .whenComplete(() => connection.on("InitializeChat", (arguments) {
              print('on initialize called');
            }))
        .whenComplete(() => connection.on("ReceiveMessage", (arguments) async {
              if (arguments![1] != await getUserId()) {
                newMessageController.haveNewMessage.value = true;
              }
              print('on receive called');
              handler();
            })));
  }

  sendMessage(
      {required String receiverId,
      required String senderId,
      required String message,
      required String groupTitle,
      String? groupName,
      String? groupImage}) async {
    await connection.invoke('SendMessage', args: [
      receiverId,
      senderId,
      message,
      groupName,
      groupTitle,
      groupImage
    ]);
  }

  Future<void> initializeChat(
      {required String receiverId,
      required String senderId,
      required String groupTitle,
      required String groupName,
      String? groupImage}) async {
    await connection.invoke('InitializeChat',
        args: [receiverId, senderId, groupName, groupTitle, groupImage]);
  }

  joinToGroup(String userId) async {
    await connection.invoke('JoinToGroup', args: [userId]);
  }

  leaveGroup(String groupName) async {
    await connection.invoke('LeaveGroup', args: [groupName]);
  }
}
