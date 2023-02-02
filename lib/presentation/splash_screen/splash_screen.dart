import 'package:alamuti/domain/controller/authentication_manager_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthenticationManager _authManager = Get.find();

  Future<void> initializeApp() async {
    if (await _authManager.checkLoginStatus()) {
      Get.offNamed('/home');
    } else {
      Get.toNamed('/register');
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
                  strokeWidth: 4,
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
