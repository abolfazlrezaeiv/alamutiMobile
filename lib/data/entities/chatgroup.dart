import 'package:alamuti/data/entities/chat_message.dart';
import 'package:alamuti/domain/controllers/detail_page_advertisement.dart';
import 'package:get/get.dart';

class ChatGroup {
  final int id;
  final String name;
  final String title;
  final bool isChecked;
  final ChatMessage lastMessage;
  final String? groupImage;
  final String? blockedUserId;
  final bool isDeleted;
  final String? reportMessage;

  ChatGroup(
      {required this.groupImage,
      required this.lastMessage,
      required this.title,
      required this.isChecked,
      required this.id,
      required this.blockedUserId,
      required this.isDeleted,
      required this.reportMessage,
      required this.name});

  factory ChatGroup.fromJson(Map<String, dynamic> json) {
    return ChatGroup(
      id: json["id"],
      name: json["name"],
      title: json["title"],
      isChecked: json["isChecked"],
      lastMessage: ChatMessage.fromJson(json['lastMessage']),
      groupImage: json["image"],
      blockedUserId: json["blockedUserId"],
      isDeleted: json["isDeleted"],
      reportMessage: json["reportMessage"],
    );
  }

  final DetailPageController detailPageController =
      Get.put(DetailPageController());

  factory ChatGroup.fromJsonForInitialization(Map<String, dynamic> json) {
    final DetailPageController detailPageController =
        Get.put(DetailPageController());
    return ChatGroup(
      id: json["id"],
      name: json["name"],
      title: json["title"],
      isChecked: json["isChecked"],
      lastMessage: ChatMessage(
        reciever: detailPageController.details[0].userId,
        sender: '',
        daySended: '',
        message: '',
        id: 2,
      ),
      groupImage: json["image"],
      blockedUserId: json["blockedUserId"],
      isDeleted: json["isDeleted"],
      reportMessage: json["reportMessage"],
    );
  }
}
