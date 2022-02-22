import 'dart:async';
import 'dart:convert';
import 'package:alamuti/app/data/entities/chat_message.dart';
import 'package:alamuti/app/data/entities/chatgroup.dart';
import 'package:alamuti/app/data/entities/list_page.dart';
import 'package:alamuti/app/data/provider/token_provider.dart';
import 'package:alamuti/app/data/provider/base_url.dart';
import 'package:alamuti/app/data/storage/cache_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';

class MessageProvider with CacheManager {
  TokenProvider tokenProvider = Get.put(TokenProvider());

  List<ChatMessage> listMessagesFromApi = [];

  List<ChatGroup> listGroupsFromApi = [];

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

  Future<void> reportChat(
    BuildContext context,
    String groupName,
    String blockedUserId,
    String reportMessage,
  ) async {
    var formData = FormData.fromMap({
      'groupname': groupName,
      'blockedUserId': blockedUserId,
      'reportMessage': reportMessage,
    });

    showLoaderDialog(context);

    await tokenProvider.api
        .put(baseChatUrl + 'api/Chat/reportgroup', data: formData)
        .whenComplete(() => Get.back());
  }

  Future<ChatGroup?> getGroup(String groupName) async {
    var response =
        await tokenProvider.api.get(baseChatUrl + 'api/Chat/group/$groupName');
    print(response.data);
    if (response.statusCode == 200) {
      return ChatGroup.fromJsonForInitialization(response.data);
    } else {
      return null;
    }
  }

  changeToSeen({
    required String groupname,
  }) async {
    await tokenProvider.api.put(
      baseChatUrl + 'api/Chat/group/$groupname',
    );
  }

  deleteMessageGroup({
    required BuildContext context,
    required String groupName,
  }) async {
    showLoaderDialog(context);
    await tokenProvider.api
        .delete(
          baseChatUrl + 'api/Chat/group/$groupName',
        )
        .whenComplete(() => Get.back());
  }

  showLoaderDialog(context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Colors.greenAccent,
          ),
        ],
      ),
    );
    showDialog(
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
      context: context,
    );
  }
}
