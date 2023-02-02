import 'package:alamuti/domain/controllers/login_controller.dart';
import 'package:alamuti/domain/controllers/otp_request_controller.dart';
import 'package:alamuti/presentation/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Registration extends StatefulWidget {
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final GlobalKey<FormState> formKey = GlobalKey();

  final OTPRequestController otpRequestController = Get.find();

  final LoginViewModel loginViewModel = Get.find();

  final TextEditingController phoneNumberTextEditingCtr =
      TextEditingController();

  final storage = new GetStorage();

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom == 0;
    phonenumberChecker();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Obx(
            () => Form(
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 0),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width / 25),
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "شماره همراه خود را وارد کنید",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: Get.width / 27),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Get.width / 50,
                            vertical: Get.height / 100),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            maxLength: 11,
                            keyboardType: TextInputType.phone,
                            controller: phoneNumberTextEditingCtr,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !value.isNum ||
                                  value.length != 11) {
                                return 'لطفا شماره همراه خود را وارد کنید';
                              } else {
                                return null;
                              }
                            },
                            decoration: inputDecoration(
                              'موبایل',
                              Icons.phone,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        width: Get.width,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: TextButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                otpRequestController.isPhoneNumber.value
                                    ? Color.fromRGBO(141, 235, 172, 1)
                                    : Colors.grey.withOpacity(0.5),
                          ),
                          onPressed: () async {
                            if (formKey.currentState?.validate() ?? false) {
                              otpRequestController.isSendingSms.value = true;

                              var result = await loginViewModel.registerUser(
                                  phoneNumberTextEditingCtr.text, context);

                              if (result == true) {
                                otpRequestController.isSendingSms.value = true;

                                otpRequestController.phoneNumber.value =
                                    phoneNumberTextEditingCtr.text;

                                Get.toNamed('/login');
                              } else {
                                otpRequestController.isSendingSms.value = false;
                              }
                            }
                          },
                          child: otpRequestController.isSendingSms.value
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: Get.height / 150),
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: Get.height / 80),
                                  child: Text(
                                    'دریافت کد ورود',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: Get.width / 25,
                                        color: Colors.white),
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height / 50,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width / 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'را مطالعه کردم و با آن موافقم',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontWeight: FontWeight.w200,
                                fontSize: Get.width / 32,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showPrivacyRules(context);
                              },
                              child: Text(
                                'قوانین مربوط به حفظ حریم خصوصی ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: Get.width / 32,
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
      ),
    );
  }

  phonenumberChecker() {
    phoneNumberTextEditingCtr.addListener(() {
      var userInput = phoneNumberTextEditingCtr.text;
      if (userInput.isNotEmpty &&
          userInput.isNum &&
          userInput.length == 11 &&
          userInput[0] == '0' &&
          userInput[1] == '9') {
        otpRequestController.isPhoneNumber.value = true;
      } else {
        otpRequestController.isPhoneNumber.value = false;
      }
    });
  }

  showPrivacyRules(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: EdgeInsets.only(left: 25, right: 25),
              title: Center(
                  child: Text(
                "حفظ حریم خصوصی",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: Get.width / 25,
                ),
              )),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              content: Container(
                height: 200,
                width: 300,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'الموتی ضمن احترام  به حریم خصوصی کاربران برای ارائه خدمات بهتر در زمان ثبت نام یا ارسال آگهی اطلاعاتی مانند شماره موبایل یا نام روستای ارسال کننده آگهی را دریافت می کند',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'موارد استفاده از اطلاعات کاربر :',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'از شماره موبایل جهت احراز هویت کاربر و ارتباط دیگر کاربران با ثبت کننده آگهی استفاده می شود. در همین حال اگر کاربران آگهی منتشر نکنند شماره تماس آنها قابل رویت نیست.',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'از نام روستا جهت ایجاد تجربه ی بهتر در زمان جستجو بین آگهی ها استفاده می شود.',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'امنیت اطلاعات شخصی',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'الموتی موظف است در این راستا تکنولوژی مورد نیاز برای هرچه امن تر شدن استفاده شما از برنامه را توسعه دهد.',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'برای هربار ورود به الموتی از رمز عبور یکبار مصرف استفاده می شود که دسترسی به آن تنها از طریق شماره همراهی که هنگام ورود به الموتی از ان استفاده کرده اید امکان پذیر است.',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'کلیه اطلاعات دریافت شده از کاربران تنها در دسترس کارکنان الموتی می باشد و در اختیار اشخاص خارج از مجموعه قرار نمی گیرد.',
                        textDirection: TextDirection.rtl,
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
  }
}
