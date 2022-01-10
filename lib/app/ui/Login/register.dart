import 'package:alamuti/app/controller/login_view_model.dart';
import 'package:alamuti/app/data/storage/cachemanager.dart';
import 'package:alamuti/app/ui/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Registeration extends StatefulWidget {
  @override
  State<Registeration> createState() => _RegisterationState();
}

class _RegisterationState extends State<Registeration> {
  final GlobalKey<FormState> formKey = GlobalKey();

  var _viewModel = Get.put(LoginViewModel());

  var phoneNumberCtr = TextEditingController();

  var isPhoneNumber = false;

  var succesed = true;

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  color: Color.fromRGBO(71, 68, 68, 0.1),
                  child: Padding(
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
                ),
                SizedBox(
                  height: Get.height / 60,
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
                        height: Get.height / 6,
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
                      width: Get.width,
                      height: Get.height / 11,
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
                                  () => Login(
                                        phonenumber: phoneNumberCtr.text,
                                      ),
                                  transition: Transition.fadeIn);
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
                    SizedBox(
                      height: Get.height / 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'را مطالعه کردم و با آن موافقم',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: Get.width / 30,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        contentPadding: EdgeInsets.only(
                                            left: 25, right: 25),
                                        title: Center(
                                            child: Text(
                                          "حفظ حریم خصوصی",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: Get.width / 25,
                                          ),
                                        )),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        content: Container(
                                          height: 200,
                                          width: 300,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  'الموتی ضمن احترام  به حریم خصوصی کاربران برای ارائه خدمات بهتر و استفاده بهینه  و مفیدتر در زمان ثبت نام یا ارسال آگهی اطلاعاتی مانند شماره موبایل کاربر و منطقه(روستا) ارسال آگهی را دریافت می کند',
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  'موارد استفاده از اطلاعات کاربر :',
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  'از شماره موبایل جهت احراز هویت کاربر و ارتباط دیگر کاربران با ثبت کننده آگهی در همین حال اگر کاربران آگهی منتشر نکنند قادر به دیدن شماره یکدیگر نیستند.',
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  'منطقه یا نام روستا به دلیل دسته بندی آگهی ها و قابلیت جستجو بر اساس مناطق از کاربر ثبت کننده آگهی دریافت می شود.',
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  'امنیت اطلاعات شخصی',
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  'الموتی موظف است در این راستا تکنولوژی مورد نیاز برای هرچه امن تر شدن استفاده شما از برنامه را توسعه دهد.',
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  'برای هربار ورود به الموتی از رمز عبور یکبار مصرف استفاده می شود که دسترسی به آن تنها از طریق شماره همراهی که هنگام ورود به الموتی از ان استفاده کرده اید امکان پذیر است.',
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  'کلیه اطلاعات دریافت شده از کاربران تنها در دسترس کارکنان الموتی می باشد و در اختیار اشخاص خارج از مجموعه قرار نخواهد گرفت.',
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ));
                                  });
                            },
                            child: Text(
                              'قوانین مربوط به حفظ حریم خصوصی ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  fontSize: Get.width / 30,
                                  color: Colors.blue),
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
