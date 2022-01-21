import 'package:alamuti/app/controller/authentication_manager_controller.dart';
import 'package:alamuti/app/data/provider/token_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthenticationManager _authManager = Get.find();

  TokenProvider tokenProviderController = Get.find();

  Future<void> initializeApp() async {
    await Future.delayed(Duration(seconds: 1));
    if (await _authManager.checkLoginStatus()) {
      Get.offNamed('/home');
    } else {
      Get.offNamed('/register');
    }
  }

  @override
  void initState() {
    initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WaitingSplashScreen();
  }
}

class WaitingSplashScreen extends StatelessWidget {
  WaitingSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          color: Color.fromRGBO(141, 235, 172, 1),
        ),
        Align(
          alignment: Alignment.center,
          child: Opacity(
            opacity: 0.8,
            child: Image.asset(
              'assets/logo/logo.png',
              width: 220,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 200,
            child: Column(
              children: [
                CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.greenAccent[700],
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
