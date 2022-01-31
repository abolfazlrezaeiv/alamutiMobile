import 'dart:async';
import 'dart:convert';
import 'package:alamuti/app/data/entities/chat_message.dart';
import 'package:alamuti/app/data/entities/chatgroup.dart';
import 'package:alamuti/app/data/entities/list_page.dart';
import 'package:alamuti/app/data/provider/token_provider.dart';
import 'package:alamuti/app/data/provider/base_url.dart';
import 'package:alamuti/app/data/storage/cache_manager.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';

class MessageProvider with CacheManager {
  TokenProvider tokenProvider = Get.put(TokenProvider());

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

    response.data.forEach(
      (element) {
        listMessagesFromApi.add(
          ChatMessage.fromJson(element),
        );
      },
    );
    return ListPage(
        itemList: listMessagesFromApi,
        grandTotalCount: xPagination['TotalCount']);
  }

  Future<ListPage<ChatGroup>> getGroups({int number = 1, int size = 10}) async {
    listGroupsFromApi = [];
    var response = await tokenProvider.api.get(
      baseChatUrl +
          'api/Chat/groupswithmessages?pageNumber=$number&pageSize=$size',
    );
    var xPagination = jsonDecode(response.headers['X-Pagination']![0]);
    print(xPagination);

    response.data.forEach(
      (element) {
        listGroupsFromApi.add(ChatGroup.fromJson(element));
      },
    );

    return ListPage(
        itemList: listGroupsFromApi,
        grandTotalCount: xPagination['TotalCount']);
  }

  Future<List<ChatGroup>> getGroupsNoPagination() async {
    List<ChatGroup> listGroupsToJoin = [];
    try {
      var response = await tokenProvider.api
          .get(
            baseChatUrl + 'api/Chat/groups',
          )
          .timeout(Duration(seconds: 5));

      response.data.forEach(
        (element) {
          listGroupsToJoin.add(ChatGroup.fromJson(element));
        },
      );
    } on TimeoutException catch (_) {
      return listGroupsToJoin;
    }

    return listGroupsToJoin;
  }

  changeToSeen({
    required String groupname,
  }) async {
    await tokenProvider.api.put(
      baseChatUrl + 'api/Chat/group/$groupname',
    );
  }

  deleteMessageGroup({
    required String groupName,
  }) async {
    await tokenProvider.api.delete(
      baseChatUrl + 'api/Chat/group/$groupName',
    );
  }
}
