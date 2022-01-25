import 'package:alamuti/app/data/entities/chat_message.dart';

class ChatGroup {
  final int id;
  final String name;
  final String title;
  final bool isChecked;
  final ChatMessage lastMessage;
  final String groupImage;

  ChatGroup(
      {required this.groupImage,
      required this.lastMessage,
      required this.title,
      required this.isChecked,
      required this.id,
      required this.name});

  factory ChatGroup.fromJson(Map<String, dynamic> json) {
    return ChatGroup(
      id: json["id"],
      name: json["name"],
      title: json["title"],
      isChecked: json["isChecked"],
      lastMessage: ChatMessage.fromJson(json['lastMessage']),
      groupImage: json["image"],
    );
  }
}
