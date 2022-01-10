import 'package:alamuti/app/controller/login_view_model.dart';
import 'package:alamuti/app/data/storage/cachemanager.dart';
import 'package:alamuti/app/ui/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Login extends StatefulWidget {
  final String phonenumber;

  Login({Key? key, required this.phonenumber}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey();
  LoginViewModel _viewModel = Get.put(LoginViewModel());

  TextEditingController passwordCtr = TextEditingController();
  bool isPinCode = false;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 150;
  bool succesed = true;

  late CountdownTimerController timercontroller;
  bool canRequestAgain = false;
  @override
  void initState() {
    timercontroller = CountdownTimerController(
      endTime: endTime,
      onEnd: () {
        setState(() {
          canRequestAgain = true;
        });
      },
    );
    passwordCtr.addListener(() {
      var userInput = passwordCtr.text;
      if (userInput.isNotEmpty && userInput.isNum && userInput.length == 4) {
        setState(() {
          isPinCode = true;
        });
      } else {
        setState(() {
          isPinCode = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom == 0;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                alignment: Alignment.centerRight,
                color: Color.fromRGBO(71, 68, 68, 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: Get.height / 14, right: 20, bottom: 15),
                      child: TextButton.icon(
                        icon: Icon(
                          CupertinoIcons.back,
                          color: Color.fromRGBO(112, 112, 112, 1),
                        ),
                        onPressed: () {
                          Get.toNamed('/register');
                        },
                        label: Text('بازگشت',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 18,
                                color: Color.fromRGBO(112, 112, 112, 1))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: Get.height / 14,
                        right: 20,
                        bottom: 15,
                      ),
                      child: Opacity(
                        opacity: 0.6,
                        child: Image.asset(
                          'assets/logo/logo.png',
                          height: Get.height / 19,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              isKeyboardOpen
                  ? SizedBox(
                      height: Get.height / 6,
                    )
                  : SizedBox(
                      height: 30,
                    ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Text(
                      "کد تایید را وارد کنید",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "کد تایید به شماره ${widget.phonenumber} ارسال شد",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Colors.green,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                            ],
                            controller: passwordCtr,
                            validator: (value) {
                              if (succesed == false) {
                                return ' ورود ناموفق لطفا کد صحیح را دوباره وارد کنید و دکمه تایید را بزنید';
                              }
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length != 4) {
                                return 'لطفا کد ارسال شده را وارد کنید';
                              }

                              return null;
                            },
                            decoration: inputDecoration(
                                'کد ورود',
                                !isPinCode
                                    ? CupertinoIcons.lock
                                    : CupertinoIcons.lock_open),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height / 180,
                  ),
                  Container(
                    width: Get.width,
                    height: Get.height / 11,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: TextButton(
                      style: ElevatedButton.styleFrom(
                        primary: isPinCode
                            ? Color.fromRGBO(141, 235, 172, 1)
                            : Colors.grey.withOpacity(0.5),
                      ),
                      onPressed: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          var result =
                              await _viewModel.loginUser(passwordCtr.text);
                          if (result == true) {
                            setState(() {
                              succesed = true;
                            });
                            Get.toNamed('/home');
                          } else {
                            setState(() {
                              succesed = false;
                            });
                          }
                          var storage = new GetStorage();
                          storage.write(CacheManagerKey.PASSWORD.toString(),
                              passwordCtr.text);
                        }
                      },
                      child: Text(
                        'تایید و ادامه',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 50,
                  ),
                  canRequestAgain
                      ? Container(
                          width: Get.width,
                          height: Get.height / 11,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: TextButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red.withOpacity(0.4),
                            ),
                            onPressed: () async {
                              await _viewModel.registerUser(widget.phonenumber);
                              var newEndTime =
                                  DateTime.now().millisecondsSinceEpoch +
                                      1000 * 150;
                              setState(() {
                                canRequestAgain = false;
                                endTime = newEndTime;
                                succesed = true;
                              });
                              timercontroller.endTime = newEndTime;
                              timercontroller.start();
                            },
                            child: Text(
                              'ارسال کد',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                          ),
                        )
                      : CountdownTimer(
                          controller: timercontroller,
                          widgetBuilder: (_, CurrentRemainingTime? time) {
                            if (time == null) {
                              return Center(child: Text(''));
                            }
                            return Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${time.min ?? 0} : ${time.sec}',
                                    style: TextStyle(
                                        fontFamily: persianNumber,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 15,
                                    width: 15,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ],
              )
            ]),
          ),
        ));
  }
}

InputDecoration inputDecoration(String labelText, IconData iconData,
    {String? prefix, String? helperText}) {
  return InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
    helperText: helperText,
    labelText: labelText,
    labelStyle: TextStyle(
      color: Colors.grey,
    ),
    prefixText: prefix,
    prefixIcon: Icon(
      iconData,
      size: 20,
    ),
    prefixIconConstraints: BoxConstraints(minWidth: 60),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:
            BorderSide(color: Color.fromRGBO(69, 230, 123, 1), width: 0.9)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:
            BorderSide(color: Color.fromRGBO(69, 230, 123, 1), width: 2)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red)),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.white)),
  );
}
