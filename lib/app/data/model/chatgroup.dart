import 'package:alamuti/app/data/model/chatMessage.dart';

class ChatGroup {
  final int id;
  final String name;
  final String title;
  final bool isChecked;
  final List messages;
  ChatGroup(
      {required this.messages,
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
