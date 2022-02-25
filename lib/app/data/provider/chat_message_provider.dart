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
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';


class MessageProvider with CacheManager {
  var authenticatedRequest = Get.put(TokenProvider());

  List<ChatMessage> messages = [];
  List<ChatGroup> groups = [];

  String getPagingQuery(int number, int size) =>
      '?PageNumber=$number&PageSize=$size';

  dynamic getHeaderPagination(Response response) =>
      jsonDecode(response.headers['pagination']![0]);


  void responseBodyToGroupList(Response response) => response.data
      .forEach((element) => groups.add(ChatGroup.fromJson(element)));

  void responseBodyToMessageList(Response response) => response.data
      .forEach((element) => messages.add(ChatMessage.fromJson(element)));

  Future<ListPage<ChatMessage>> getMessages(
      {int number = 1, int size = 10, required String groupName}) async {
    messages = [];

    var endpoint = '/$groupName/massages${getPagingQuery(number, size)}';
    var response = await authenticatedRequest.api.get(baseChatUrl + endpoint);


    var pagination = getHeaderPagination(response);
    print(pagination);

    responseBodyToMessageList(response);

    return ListPage(
        itemList: messages,
        grandTotalCount: pagination['TotalCount']);
  }

  Future<ListPage<ChatGroup>> getGroups({int number = 1, int size = 10}) async {
    groups = [];
    print('0');


    var endpoint = getPagingQuery(number, size);
    print('0.5');

    var response = await authenticatedRequest.api.get(baseChatUrl + endpoint);

    print('1');

    var pagination = jsonDecode(response.headers['Pagination']![0]);
    print(pagination);
    print('2');

    responseBodyToGroupList(response);

    return ListPage(
        itemList: groups, grandTotalCount: pagination['TotalCount']);
  }

  Future<List<ChatGroup>> getGroupsNoPagination() async {
    List<ChatGroup> listGroupsToJoin = [];
    try {
      var response = await authenticatedRequest.api
          .get(baseChatUrl + '/no-paginated')
          .timeout(Duration(seconds: 10));

      responseBodyToGroupList(response);

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

    await authenticatedRequest.api
        .put(baseChatUrl + '/report', data: formData)
        .whenComplete(() => Get.back());
  }

  Future<ChatGroup?> getGroup(String groupName) async {
    try{
      var response = await authenticatedRequest.api
          .get(baseChatUrl + '/$groupName')
          .timeout(Duration(seconds: 8));
      print(response.data);
      if (response.statusCode == 200) {
        return ChatGroup.fromJsonForInitialization(response.data);
      } else {
        return null;
      }
    }on TimeoutException catch(_){
      throw TimeoutException('');
    }

  }

  changeToSeen({
    required String groupname,
  }) async {
    await authenticatedRequest.api.put(
      baseChatUrl + '/$groupname',
    );
  }

  deleteChat({
    required BuildContext context,
    required String groupName,
  }) async {
    showLoaderDialog(context);
    await authenticatedRequest.api
        .delete(
          baseChatUrl + '/$groupName',
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
