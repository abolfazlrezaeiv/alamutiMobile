import 'package:alamuti/app/data/model/chatMessage.dart';
import 'package:alamuti/app/data/storage/cachemanager.dart';
import 'package:get/get.dart';

class ChatMessageController extends GetxController with CacheManager {
  final messageList = [].obs;

  void addMessage(ChatMessage message) async {
    messageList.add(message);
  }

  bool isSender() {
    return (messageList[messageList.length] as ChatMessage).sender ==
        getUserId();
  }
}
