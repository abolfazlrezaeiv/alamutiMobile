import 'package:alamuti/app/controller/login_view_model.dart';
import 'package:alamuti/app/data/storage/cachemanager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: formKey,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          alignment: Alignment.centerRight,
          color: Color.fromRGBO(71, 68, 68, 0.1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70, right: 20, bottom: 15),
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
                padding: const EdgeInsets.only(
                  top: 70,
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
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 5,
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  "کد تایید را وارد کنید",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  "کد تایید به شماره ${widget.phonenumber} ارسال شد",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  controller: passwordCtr,
                  validator: (value) {
                    return (value == null ||
                            value.isEmpty ||
                            value.length != 4 ||
                            !value.isNum)
                        ? 'لطفا کد ارسال شده را وارد کنید'
                        : null;
                  },
                  decoration: inputDecoration(
                      'کد ورود',
                      !isPinCode
                          ? CupertinoIcons.lock
                          : CupertinoIcons.lock_open),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextButton(
                style: ElevatedButton.styleFrom(
                  primary: isPinCode
                      ? Color.fromRGBO(141, 235, 172, 1)
                      : Colors.grey.withOpacity(0.5),
                ),
                onPressed: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    await _viewModel.loginUser(passwordCtr.text);
                    var storage = new GetStorage();
                    storage.write(
                        CacheManagerKey.PASSWORD.toString(), passwordCtr.text);
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
          ],
        )
      ]),
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
