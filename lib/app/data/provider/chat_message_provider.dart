import 'dart:convert';
import 'package:alamuti/app/controller/advertisement_pagination_controller.dart';
import 'package:alamuti/app/controller/chat_group_controller.dart';
import 'package:alamuti/app/controller/chat_message_controller.dart';
import 'package:alamuti/app/controller/new_message_controller.dart';
import 'package:alamuti/app/data/entities/chat_message.dart';
import 'package:alamuti/app/data/entities/chatgroup.dart';
import 'package:alamuti/app/data/entities/list_page.dart';
import 'package:alamuti/app/data/provider/token_provider.dart';
import 'package:alamuti/app/data/provider/base_url.dart';
import 'package:alamuti/app/data/storage/cache_manager.dart';
import 'package:dio/dio.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';

class MessageProvider with CacheManager {
  TokenProvider tokenProvider = Get.put(TokenProvider());

  AdvertisementPaginationController advertisementPaginationController =
      Get.put(AdvertisementPaginationController());

  List<ChatMessage> listMessagesFromApi = [];

  List<ChatGroup> listGroupsFromApi = [];

  GetStorage storage = GetStorage();

  Future<ListPage<ChatMessage>> getGroupMessages(
      {int number = 1, int size = 10, required String groupname}) async {
    var response = await tokenProvider.api.get(
      baseChatUrl +
          'api/Chat/massages/$groupname?pageNumber=$number&pageSize=$size',
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
    return ListPage(
        itemList: listMessagesFromApi,
        grandTotalCount: advertisementPaginationController.totalAds.value);
  }

  Future<ListPage<ChatGroup>> getGroups({int number = 1, int size = 10}) async {
    listGroupsFromApi = [];
    var response = await tokenProvider.api.get(
      baseChatUrl +
          'api/Chat/groupswithmessages?pageNumber=$number&pageSize=$size',
    );
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
        listGroupsFromApi.add(ChatGroup.fromJson(element));
      },
    );

    return ListPage(
        itemList: listGroupsFromApi,
        grandTotalCount: advertisementPaginationController.totalAds.value);
  }

  Future<List<ChatGroup>> getGroupsNoPagination() async {
    List<ChatGroup> listGroupsToJoin = [];
    var response = await tokenProvider.api.get(
      baseChatUrl + 'api/Chat/groups',
    );

    response.data.forEach(
      (element) {
        listGroupsToJoin.add(ChatGroup.fromJson(element));
      },
    );

    return listGroupsToJoin;
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

  // postMessage(
  //     {required String sender,
  //     required int id,
  //     required String message,
  //     required String reciever}) async {
  //   var formData = FormData.fromMap({
  //     'id': id,
  //     'sender': sender,
  //     'message': message,
  //     'reciever': reciever,
  //   });
  //   await tokenProvider.api.post(
  //     baseChatUrl + 'api/chat',
  //     data: formData,
  //   );
  // }

  deleteMessageGroup({
    required String groupName,
  }) async {
    await tokenProvider.api.delete(
      baseChatUrl + 'api/Chat/group/$groupName',
    );
  }
}
