import 'package:alamuti/app/data/entities/chat_message.dart';
import 'package:alamuti/app/data/storage/cache_manager.dart';
import 'package:get/get.dart';

class ChatMessageController extends GetxController with CacheManager {
  final messageList = [].obs;

  void addMessage(ChatMessage message) {
    messageList.add(message);
  }
}
