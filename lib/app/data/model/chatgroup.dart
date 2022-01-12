import 'package:alamuti/app/data/model/chat_message.dart';

class ChatGroup {
  final int id;
  final String name;
  final String title;
  final bool isChecked;
  final ChatMessage lastMessage;
  final String? groupImage;

  ChatGroup(
      {required this.groupImage,
      required this.lastMessage,
      required this.title,
      required this.isChecked,
      required this.id,
      required this.name});

  //     {
  //   List<ChatMessage> computedList = [];
  //   messages.forEach((element) {
  //     ChatMessage.fromJson(messages);
  //   });
  //   this.messages = computedList;
  // }

  void add(ChatGroup group) {}
}
