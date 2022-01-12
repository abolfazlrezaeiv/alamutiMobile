import 'package:alamuti/app/controller/chat_group_controller.dart';
import 'package:alamuti/app/controller/chat_message_controller.dart';
import 'package:alamuti/app/controller/chat_target_controller.dart';
import 'package:alamuti/app/controller/new_message_controller.dart';
import 'package:alamuti/app/data/provider/base_url.dart';
import 'package:alamuti/app/data/provider/chat_message_provider.dart';
import 'package:alamuti/app/data/storage/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signalr_core/signalr_core.dart';

class SignalRHelper with CacheManager {
  late HubConnection connection;

  ChatTargetUserController chatTargetUserController =
      Get.put(ChatTargetUserController());

  ChatMessageController chatMessageController =
      Get.put(ChatMessageController());

  ChatGroupController chatGroupController = Get.put(ChatGroupController());

  NewMessageController newMessageController = Get.put(NewMessageController());

  var mp = MessageProvider();

  SignalRHelper() {
    connection = HubConnectionBuilder()
        .withUrl(
          baseLoginUrl + 'chat',
          HttpConnectionOptions(
            skipNegotiation: true,
            transport: HttpTransportType.webSockets,
          ),
        )
        .build();
  }

  initiateConnection() async {
    await connection.start();
  }

  reciveMessage() async {
    connection.on("ReceiveMessage", (arguments) async {
      chatTargetUserController.userId.value = arguments![1];

      MessageProvider mp = MessageProvider();
      await mp.getGroupMessages(arguments[3]);

      await connection
          .invoke('CreatenewGroup', args: [arguments[3], arguments[4]]);
      if (arguments[1] != getUserId()) {
        newMessageController.haveNewMessage.value = true;
      }
      await mp.getGroups();
      await mp.getGroupMessages(arguments[3]);
    });
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

  createGroup(String userId) async {
    await connection.invoke('CreateMyGroup', args: [userId]);
  }

  leaveGroup(String groupname) async {
    await connection.invoke('LeaveGroup', args: [groupname]);
  }

  closeConnection(BuildContext context) async {
    if (connection.state == HubConnectionState.connected) {
      await connection.stop();
    }
  }
}
