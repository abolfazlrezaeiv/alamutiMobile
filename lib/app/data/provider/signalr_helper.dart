import 'package:alamuti/app/controller/chat_group_controller.dart';
import 'package:alamuti/app/controller/chat_message_controller.dart';
import 'package:alamuti/app/controller/message_notifier_controller.dart';
import 'package:alamuti/app/controller/new_message_controller.dart';
import 'package:alamuti/app/data/provider/base_url.dart';
import 'package:alamuti/app/data/provider/chat_message_provider.dart';
import 'package:alamuti/app/data/storage/cache_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:signalr_core/signalr_core.dart';

class SignalRHelper with CacheManager {
  late HubConnection connection;

  ChatMessageController chatMessageController =
      Get.put(ChatMessageController());

  ChatGroupController chatGroupController = Get.put(ChatGroupController());

  NewMessageController newMessageController = Get.put(NewMessageController());

  MessageNotifierController messageNotifierController =
      Get.put(MessageNotifierController());

  MessageProvider messageProvider = MessageProvider();

  GetStorage storage = GetStorage();

  SignalRHelper() {
    connection = HubConnectionBuilder()
        .withUrl(baseLoginUrl + 'chat', HttpConnectionOptions())
        .withAutomaticReconnect()
        .build();

    connection.start();
    connection.on("ReceiveMessage", (arguments) async {
      if (arguments![0] ==
          await storage.read(CacheManagerKey.USERID.toString())) {
        newMessageController.haveNewMessage.value = true;
      }
      await connection
          .invoke('CreatenewGroup', args: [arguments[3], arguments[4]]);
      print('on recivee called');
      messageNotifierController.connection.insert(0, 'a');
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
}
