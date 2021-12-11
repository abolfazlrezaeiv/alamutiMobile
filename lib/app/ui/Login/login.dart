import 'package:alamuti/app/controller/login_view_model.dart';
import 'package:alamuti/app/data/storage/cachemanager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> formKey = GlobalKey();
  LoginViewModel _viewModel = Get.put(LoginViewModel());

  TextEditingController phoneNumberCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  FormType _formType = FormType.register;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _formType == FormType.login ? loginForm() : registerForm(),
    );
  }

  Form loginForm() {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: formKey,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextFormField(
          validator: (value) {
            return (value == null || value.isEmpty)
                ? 'Please Enter Password'
                : null;
          },
          controller: passwordCtr,
          decoration: inputDecoration('رمز', Icons.lock),
        ),
        ElevatedButton(
          onPressed: () async {
            if (formKey.currentState?.validate() ?? false) {
              await _viewModel.loginUser(passwordCtr.text);
              setState(() {
                _formType = FormType.register;
              });
            }
          },
          child: Text('ثبت'),
        ),
      ]),
    );
  }

  Form registerForm() {
    return Form(
      key: formKey,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          alignment: Alignment.centerRight,
          color: Color.fromRGBO(71, 68, 68, 0.1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            child: Opacity(
              opacity: 0.8,
              child: Image.asset(
                'assets/logo/logo.png',
                height: MediaQuery.of(context).size.height / 13,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
            child: Opacity(
                opacity: 0.8,
                child: Text(
                  "ورود یا عضویت",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 30),
                )),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 4,
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  "شماره همراه خود را وارد کنید",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  controller: phoneNumberCtr,
                  validator: (value) {
                    return (value == null || value.isEmpty)
                        ? 'لطفا شماره همراه خود را وارد کنید'
                        : null;
                  },
                  decoration: inputDecoration('موبایل', Icons.phone),
                ),
              ),
            ),
            Container(
              width: 400,
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey.withOpacity(0.5),
                ),
                onPressed: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    await _viewModel.registerUser(phoneNumberCtr.text);
                    var storage = new GetStorage();
                    storage.write(CacheManagerKey.PHONENUMBER.toString(),
                        phoneNumberCtr.text);
                    setState(() {
                      _formType = FormType.login;
                    });
                  }
                },
                child: Text(
                  'تایید',
                ),
              ),
            ),
          ],
        )
      ]),
    );
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
        borderSide: BorderSide(color: Colors.green)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.green)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red)),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.white)),
  );
}

enum FormType { login, register }
