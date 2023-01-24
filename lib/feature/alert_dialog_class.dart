import 'package:alamuti/controller/authentication_manager_controller.dart';
import 'package:alamuti/controller/selected_tap_controller.dart';
import 'package:alamuti/data/apicall/advertisement_apicall.dart';
import 'package:alamuti/data/apicall/chat_message_apicall.dart';
import 'package:alamuti/feature/widgets/buttom_navbar_items.dart';
import 'package:alamuti/feature/widgets/description_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Alert {
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
              Get.put(ScreenController()).selectedIndex.value = 3;
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

  static logoutAlertDialog({required BuildContext context}) {
    Get.defaultDialog(
      radius: 5,
      title: 'از خروج از حساب مطمعن هستید',
      barrierDismissible: false,
      titlePadding: EdgeInsets.all(20),
      titleStyle: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 16,
      ),
      content: Text(
        '',
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
              AuthenticationManager auth = Get.put(AuthenticationManager());
              auth.logOut();
            },
            child: Text(
              'خروج',
              style: TextStyle(
                  fontWeight: FontWeight.w300, fontSize: 14, color: Colors.red),
            )),
      ),
    );
  }

  static showAdvertisementReportDialog(
    context,
    TextEditingController reportTextEditingCtrl,
    int adsId,
  ) {
    AlertDialog alert = AlertDialog(
        backgroundColor: Colors.white,
        elevation: 0,
        content: Container(
          height: Get.height / 2.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'درباره مشکل توضیح دهید.',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: Get.width / 30,
                    fontWeight: FontWeight.w300),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  DescriptionTextField(
                      minline: 6,
                      maxline: 6,
                      textEditingController: reportTextEditingCtrl),
                  TextButton(
                      onPressed: () async {
                        Get.back();
                        AdvertisementAPICall ap = AdvertisementAPICall();
                        await ap.sendReport(
                          id: adsId,
                          report: reportTextEditingCtrl.text,
                        );
                      },
                      child: Text(
                        'ثبت گزارش',
                        style: TextStyle(
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.w500),
                      ))
                ],
              ),
            ],
          ),
        ));
    showDialog(
      barrierDismissible: true,
      builder: (BuildContext context) {
        return alert;
      },
      context: context,
    );
  }

  static showChatReportDialog(
      context,
      TextEditingController reportTextEditingCtrl,
      String groupName,
      String blockedUserId) {
    AlertDialog alert = AlertDialog(
        backgroundColor: Colors.white,
        elevation: 0,
        content: Container(
          height: Get.height / 2.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'درباره مشکل توضیح دهید.',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: Get.width / 30,
                    fontWeight: FontWeight.w300),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  DescriptionTextField(
                      minline: 6,
                      maxline: 6,
                      textEditingController: reportTextEditingCtrl),
                  TextButton(
                      onPressed: () async {
                        Get.back();

                        MessageProvider mp = MessageProvider();

                        await mp.reportChat(
                          context,
                          groupName,
                          blockedUserId,
                          reportTextEditingCtrl.text,
                        );
                        Get.put(ScreenController()).selectedIndex.value = 3;
                        Get.toNamed('/home');
                      },
                      child: Text(
                        'ثبت گزارش',
                        style: TextStyle(
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.w500),
                      ))
                ],
              ),
            ],
          ),
        ));
    showDialog(
      barrierDismissible: true,
      builder: (BuildContext context) {
        return alert;
      },
      context: context,
    );
  }

  static showDeletedMessageDialog({required context, required String message}) {
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
}
