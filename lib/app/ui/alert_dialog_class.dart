import 'package:alamuti/app/controller/chat_info_controller.dart';
import 'package:alamuti/app/data/provider/chat_message_provider.dart';
import 'package:alamuti/app/ui/widgets/buttom_navbar_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Alert {
  final ChatInfoController chatInfoController = Get.put(ChatInfoController());

  static void showStatusDialog({required context, required String message}) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      elevation: 3,
      content: Text(
        message,
        textDirection: TextDirection.rtl,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: Get.width / 25,
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Get.back(closeOverlays: true);
            },
            child: Text(
              'تایید',
              style: TextStyle(
                color: Colors.greenAccent,
                fontWeight: FontWeight.w400,
                fontSize: Get.width / 27,
              ),
            ))
      ],
    );
    showDialog(
      barrierDismissible: true,
      builder: (BuildContext context) {
        return alert;
      },
      context: context,
    );
  }

  static chatDeleteDialog(
      {required String groupName, required BuildContext context}) {
    Get.defaultDialog(
      radius: 5,
      title: 'از حذف چت مطمئن هستید ؟ ',
      barrierDismissible: false,
      titlePadding: EdgeInsets.all(20),
      titleStyle: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 16,
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'کاربر دیگر نمی تواند به مکالمه ادامه دهد',
          style: TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 14,
          ),
        ),
      ),
      cancel: Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            'انصراف',
            style: TextStyle(
                fontWeight: FontWeight.w300, fontSize: 14, color: Colors.green),
          ),
        ),
      ),
      confirm: Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextButton(
            onPressed: () async {
              newMessageController.haveNewMessage.value = false;

              MessageProvider messageProvider = MessageProvider();

              await messageProvider.deleteMessageGroup(
                context: context,
                groupName: groupName,
              );

              Get.toNamed('/home');
            },
            child: Text(
              'حذف',
              style: TextStyle(
                  fontWeight: FontWeight.w300, fontSize: 14, color: Colors.red),
            )),
      ),
    );
  }
}
