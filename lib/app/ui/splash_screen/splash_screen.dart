import 'package:alamuti/app/controller/ConnectionController.dart';
import 'package:alamuti/app/controller/token_provider.dart';
import 'package:alamuti/app/ui/onboard/onboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> initializeSettings() async {
    //Simulate other services for 3 seconds
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeSettings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return WaitingSplashScreen();
        } else {
          if (snapshot.hasError)
            return errorView(snapshot);
          else {
            return OnBoard();
          }
        }
      },
    );
  }
}

Scaffold errorView(AsyncSnapshot<Object?> snapshot) {
  return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
}

class WaitingSplashScreen extends StatelessWidget {
  WaitingSplashScreen({Key? key}) : super(key: key);
  ConnectionController connectionController = Get.put(ConnectionController());

  @override
  Widget build(BuildContext context) {
    connectionController.checkConnectionStatus();
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
                connectionController.isConnected.value
                    ? CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color.fromRGBO(189, 121, 97, 1),
                      )
                    : Text('لطفا ارتباط با اینترنت همراه خود را بررسی کنید')
              ],
            ),
          ),
        )
      ],
    ));
  }
}
