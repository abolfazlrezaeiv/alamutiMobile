import 'package:alamuti/app/controller/login_view_model.dart';
import 'package:alamuti/app/data/storage/cachemanager.dart';
import 'package:alamuti/app/ui/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

class Registeration extends StatefulWidget {
  @override
  State<Registeration> createState() => _RegisterationState();
}

class _RegisterationState extends State<Registeration> {
  final GlobalKey<FormState> formKey = GlobalKey();

  LoginViewModel _viewModel = Get.put(LoginViewModel());

  TextEditingController phoneNumberCtr = TextEditingController();

  bool isPhoneNumber = false;

  bool succesed = true;

  var isSendingSms = false;
  @override
  void initState() {
    super.initState();
    phoneNumberCtr.addListener(() {
      var userInput = phoneNumberCtr.text;
      if (userInput.isNotEmpty &&
          userInput.isNum &&
          userInput.length == 11 &&
          userInput[0] == '0' &&
          userInput[1] == '9') {
        setState(() {
          isPhoneNumber = true;
        });
      } else {
        setState(() {
          isPhoneNumber = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom == 0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            key: formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                alignment: Alignment.centerRight,
                color: Color.fromRGBO(71, 68, 68, 0.1),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 14,
                    right: 20,
                    bottom: 15,
                  ),
                  child: Opacity(
                    opacity: 0.6,
                    child: Image.asset(
                      'assets/logo/logo.png',
                      height: MediaQuery.of(context).size.height / 19,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 60,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  child: Opacity(
                      opacity: 0.8,
                      child: Text(
                        "ورود یا عضویت",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 30,
                            color: Color.fromRGBO(112, 112, 112, 1)),
                      )),
                ),
              ),
              isKeyboardOpen
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height / 6,
                    )
                  : SizedBox(
                      height: 30,
                    ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "شماره همراه خود را وارد کنید",
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 18),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: phoneNumberCtr,
                        validator: (value) {
                          if (succesed == false) {
                            return 'مشکل در ارتباط , لطفا اتصال به اینترنت تلفن همراه خود را بررسی کنید';
                          }
                          if (value == null ||
                              value.isEmpty ||
                              !value.isNum ||
                              value.length != 11) {
                            return 'لطفا شماره همراه خود را وارد کنید';
                          } else {
                            return null;
                          }
                        },
                        decoration: inputDecoration('موبایل', Icons.phone),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 9,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: TextButton(
                      style: ElevatedButton.styleFrom(
                        primary: isPhoneNumber
                            ? Color.fromRGBO(141, 235, 172, 1)
                            : Colors.grey.withOpacity(0.5),
                      ),
                      onPressed: () async {
                        //editt
                        setState(() {
                          succesed = true;
                        });
                        if (formKey.currentState?.validate() ?? false) {
                          setState(() {
                            isSendingSms = true;
                          });
                          var result = await _viewModel
                              .registerUser(phoneNumberCtr.text);

                          if (result == true) {
                            var storage = new GetStorage();
                            storage.write(
                                CacheManagerKey.PHONENUMBER.toString(),
                                phoneNumberCtr.text);
                            setState(() {
                              succesed = true;
                              isSendingSms = true;
                            });
                            Get.to(
                                Login(
                                  phonenumber: phoneNumberCtr.text,
                                ),
                                transition: Transition.noTransition);
                          } else {
                            setState(() {
                              succesed = false;
                            });
                          }
                          Future.delayed(Duration(seconds: 3), () {
                            setState(() {
                              succesed = false;
                              isSendingSms = false;
                            });
                            formKey.currentState?.validate();
                          });
                        }
                      },
                      child: isSendingSms
                          ? CircularProgressIndicator()
                          : Text(
                              'دریافت کد ورود',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                    ),
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
