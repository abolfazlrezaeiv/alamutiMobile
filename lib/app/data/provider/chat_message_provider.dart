import 'dart:convert';

import 'package:alamuti/app/controller/advertisement_pagination_controller.dart';
import 'package:alamuti/app/controller/chat_group_controller.dart';
import 'package:alamuti/app/controller/chat_message_controller.dart';
import 'package:alamuti/app/controller/new_message_controller.dart';
import 'package:alamuti/app/data/provider/token_provider.dart';
import 'package:alamuti/app/data/model/chat_message.dart';
import 'package:alamuti/app/data/model/chatgroup.dart';
import 'package:alamuti/app/data/provider/base_url.dart';
import 'package:alamuti/app/data/storage/cache_manager.dart';
import 'package:dio/dio.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';

class MessageProvider with CacheManager {
  TokenProvider tokenProvider = Get.put(TokenProvider());

  ChatMessageController chatMessageController =
      Get.put(ChatMessageController());

  ChatGroupController chatGroupController = Get.put(ChatGroupController());

  NewMessageController newMessageController = Get.put(NewMessageController());

  AdvertisementPaginationController advertisementPaginationController =
      Get.put(AdvertisementPaginationController());

  List<ChatMessage> listMessagesFromApi = [];

  GetStorage storage = GetStorage();

  Future<void> getGroupMessages(String groupname) async {
    var response = await tokenProvider.api.get(
      baseChatUrl +
          'api/Chat/massages/$groupname?pageNumber=${advertisementPaginationController.currentPage.value}&pageSize=15',
    );
    listMessagesFromApi = [];
    var xPagination = jsonDecode(response.headers['X-Pagination']![0]);
    print(xPagination);
    advertisementPaginationController.currentPage.value =
        xPagination['CurrentPage'];

    advertisementPaginationController.totalPages.value =
        xPagination['TotalPages'];

    advertisementPaginationController.totalAds.value =
        xPagination['TotalCount'];

    advertisementPaginationController.hasNext.value = xPagination['HasNext'];

    advertisementPaginationController.hasBack.value =
        xPagination['HasPrevious'];

    response.data.forEach(
      (element) {
        listMessagesFromApi.add(
          ChatMessage.fromJson(element),
        );
      },
    );
    if (advertisementPaginationController.currentPage.value == 1) {
      chatMessageController.messageList.value = listMessagesFromApi;
    } else {
      chatMessageController.messageList.addAll(listMessagesFromApi);
    }
  }

  Future<void> getGroups() async {
    List<ChatGroup> mygroups = [];
    var response = await tokenProvider.api.get(
      baseChatUrl + 'api/Chat/groupswithmessages',
    );
    if (response.statusCode == 200) {
      response.data.forEach(
        (element) {
          mygroups.add(ChatGroup.fromJson(element));
        },
      );

      chatGroupController.groupList.value = mygroups;
      for (var i = 0; i < chatGroupController.groupList.length; i++) {
        if ((chatGroupController.groupList[i].isChecked == false &&
            chatGroupController.groupList[i].lastMessage.reciever ==
                await storage.read(CacheManagerKey.USERID.toString()))) {
          newMessageController.haveNewMessage.value = true;
        }
      }
    } else {
      Get.defaultDialog(
          title: 'دریافت اطلاعات ناموفق بود',
          textConfirm: 'لطفا دوباره تلاش کنید');
    }
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
    await tokenProvider.api.put(
      baseChatUrl + 'api/Chat',
      data: formData,
    );
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
    await tokenProvider.api.post(
      baseChatUrl + 'api/chat',
      data: formData,
    );
  }

  deleteMessageGroup({
    required String groupName,
  }) async {
    for (var i = 0; i < chatGroupController.groupList.length; i++) {
      if (chatGroupController.groupList[i].name == groupName) {
        chatGroupController.groupList.removeAt(i);
        break;
      }
    }

    await tokenProvider.api.delete(
      baseChatUrl + 'api/Chat/group/$groupName',
    );
  }
}
