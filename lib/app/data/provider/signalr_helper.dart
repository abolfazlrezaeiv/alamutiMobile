import 'package:alamuti/app/controller/chat_group_controller.dart';
import 'package:alamuti/app/controller/chat_message_controller.dart';
import 'package:alamuti/app/controller/chat_target_controller.dart';
import 'package:alamuti/app/data/model/chatMessage.dart';
import 'package:alamuti/app/data/provider/chat_message_provider.dart';
import 'package:alamuti/app/data/storage/cachemanager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:signalr_core/signalr_core.dart';

class SignalRHelper with CacheManager {
  late HubConnection connection;
  ChatTargetUserController chatTargetUserController =
      Get.put(ChatTargetUserController());
  ChatMessageController chatMessageController =
      Get.put(ChatMessageController());
  ChatGroupController chatGroupController = Get.put(ChatGroupController());

  var mp = MessageProvider();

  SignalRHelper() {
    connection = HubConnectionBuilder()
        .withUrl(
          'http://192.168.1.102:5113/chat',
          HttpConnectionOptions(
            // logging: (level, message) => print(message),
            skipNegotiation: true,
            transport: HttpTransportType.webSockets,
          ),
        )
        .build();
  }

  initiateConnection() async {
    await connection.start();
  }

  reciveMessage() {
    connection.on("ReceiveMessage", (arguments) async {
      print('on recive signal');

      chatTargetUserController.userId.value = arguments![1];
      var storage = GetStorage();

      MessageProvider mp = MessageProvider();
      await mp.getGroupMessages(arguments[3]);

      // if (arguments[0] == storage.read(CacheManagerKey.USERID.toString())) {
      //   chatMessageController.addMessage(ChatMessage(
      //       id: 2,
      //       sender: arguments.toString(),
      //       message: arguments[2].toString(),
      //       reciever: arguments.toString()));
      // }

      // await connection
      //     .invoke('CreatenewGroup', args: [arguments[0], arguments[1]]);
      await connection
          .invoke('CreatenewGroup', args: [arguments[3], arguments[4]]);

      await mp.getGroups();
      await mp.getGroupMessages(arguments[3]);
    });
  }

  sendMessage(
      {required String receiverId,
      required String senderId,
      required String message,
      required String grouptitle,
      String? groupname}) async {
    await connection.invoke('SendMessage',
        args: [receiverId, senderId, message, groupname, grouptitle]);
  }

  createGroup(String userId) async {
    await connection.invoke('CreateMyGroup', args: [userId]);
    print('joined the group');
  }

  leaveGroup(String groupname) async {
    await connection.invoke('LeaveGroup', args: [groupname]);
    print('left the group');
  }

  closeConnection(BuildContext context) async {
    if (connection.state == HubConnectionState.connected) {
      await connection.stop();
    }
  }
}
