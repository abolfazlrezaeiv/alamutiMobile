import 'package:alamuti/app/data/model/chatMessage.dart';
import 'package:alamuti/app/data/model/chatgroup.dart';
import 'package:get/get.dart';

class ChatGroupController extends GetxController {
  final groupList = [].obs;

  void addMessage(ChatGroup group) async {
    groupList.add(group);
  }
}
