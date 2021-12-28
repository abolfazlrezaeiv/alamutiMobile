import 'package:alamuti/app/controller/chat_group_controller.dart';
import 'package:alamuti/app/controller/chat_message_controller.dart';
import 'package:alamuti/app/controller/last_message_sender_controller.dart';
import 'package:alamuti/app/controller/new_message_controller.dart';
import 'package:alamuti/app/controller/token_provider.dart';
import 'package:alamuti/app/data/model/chatMessage.dart';
import 'package:alamuti/app/data/model/chatgroup.dart';
import 'package:alamuti/app/data/provider/base_url.dart';
import 'package:alamuti/app/data/storage/cachemanager.dart';
import 'package:dio/dio.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';

class MessageProvider with CacheManager {
  TokenProvider tokenProvider = Get.put(TokenProvider());
  ChatMessageController chatMessageController =
      Get.put(ChatMessageController());

  ChatGroupController chatGroupController = Get.put(ChatGroupController());

  LastMessageSenderIDController lastMessageSenderIDController =
      Get.put(LastMessageSenderIDController());

  NewMessageController newMessageController = Get.put(NewMessageController());

  getMassages() async {
    var response = await tokenProvider.api.get(
      baseChatUrl + 'api/chat',
    );

    var myMap = response.data;
    List<ChatMessage> mymessages = [];
    myMap.forEach(
      (element) {
        mymessages.add(
          ChatMessage(
            sender: element['sender'],
            id: element['id'],
            message: element['message'],
            reciever: element['reciever'],
            daySended: element['daySended'],
          ),
        );
      },
    );
    chatMessageController.messageList.value = mymessages;
    // print(mymessages.length);
    // return mymessages;
  }

  getGroupMessages(String groupname) async {
    var response = await tokenProvider.api.get(
      baseChatUrl + 'api/Chat/massages/${groupname}',
    );

    var myMap = response.data;
    List<ChatMessage> mymessages = [];
    myMap.forEach(
      (element) {
        mymessages.add(
          ChatMessage(
            sender: element['sender'],
            id: element['id'],
            message: element['message'],
            reciever: element['reciever'],
            daySended: element['daySended'],
          ),
        );
      },
    );
    chatMessageController.messageList.value = mymessages;
    // print(mymessages.length);
    // return mymessages;
  }

  Future<String> getLastItemOfGroup(String groupname) async {
    var response = await tokenProvider.api.get(
      baseChatUrl + 'api/Chat/groups/${groupname}',
    );

    var sender = response.data['sender'];
    var message = response.data['message'];

    print('$sender from messageprovider');
    lastMessageSenderIDController.lastMessage.add(message);

    lastMessageSenderIDController.lastsender.add(sender);
    return sender;
    // print(mymessages.length);
    // return mymessages;
  }

  Future<List<ChatGroup>> getGroups() async {
    var response = await tokenProvider.api.get(
      baseChatUrl + 'api/Chat/groupswithmessages',
    );

    var myMap = response.data;
    // print('is working in message provider ${response.statusCode}');
    List<ChatGroup> mygroups = [];
    myMap.forEach(
      (element) {
        mygroups.add(
          ChatGroup(
            name: element['name'],
            id: element['id'],
            title: element['title'],
            isChecked: element['isChecked'],
            lastMessage: ChatMessage.fromJson(element['lastMessage']),
            groupImage: element['image'],
          ),
        );
      },
    );
    // print('is working in message provider ${response.statusCode}');
    chatGroupController.groupList.value = mygroups;
    for (var i = 0; i < chatGroupController.groupList.value.length; i++) {
      if ((chatGroupController.groupList[i].isChecked == false &&
          chatGroupController.groupList[i].lastMessage.sender != getUserId())) {
        newMessageController.haveNewMessage.value = true;
      }
    }
    // print('getgroup from home page');
    // print('${newMessageController.haveNewMessage.value} value of new message');
    return mygroups;
    // print(mymessages.length);
    // return mymessages;
  }

  updateGroupStatus({
    required String name,
    required int id,
    required String title,
    required bool isChecked,
  }) async {
    var formData = FormData.fromMap({
      'id': id,
      'title': title,
      'name': name,
      'isChecked': isChecked,
    });
    var response = await tokenProvider.api.put(
      baseChatUrl + 'api/Chat',
      data: formData,
    );
    // print(response.statusMessage);
    // print(response.statusCode);
  }

  postMessage(
      {required String sender,
      required int id,
      required String message,
      required String reciever}) async {
    var formData = FormData.fromMap({
      'id': id,
      'sender': sender,
      'message': message,
      'reciever': reciever,
    });
    var response = await tokenProvider.api.post(
      baseChatUrl + 'api/chat',
      data: formData,
    );
    // print(response.statusMessage);
    // print(response.statusCode);
  }

  deleteMessageGroup({
    required String groupName,
  }) async {
    await tokenProvider.api.delete(
      baseChatUrl + 'api/Chat/groups/$groupName',
    );
  }
}
