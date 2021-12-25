import 'package:alamuti/app/controller/chat_group_controller.dart';
import 'package:alamuti/app/data/provider/chat_message_provider.dart';
import 'package:alamuti/app/data/storage/cachemanager.dart';
import 'package:get/get.dart';

class SenderController extends GetxController with CacheManager {
  var canChange = false.obs;
  ChatGroupController chatGroupController = Get.put(ChatGroupController());
  var mp = MessageProvider();

  Future<bool> checkSender(int index) async {
    var result = await mp
            .getLastItemOfGroup(chatGroupController.groupList[index].name) ==
        await getUserId();

    canChange.value = result;
    return canChange.value;
  }
}
