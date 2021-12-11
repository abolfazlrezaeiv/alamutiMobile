import 'package:alamuti/app/data/provider/token_provider.dart';
import 'package:alamuti/app/ui/home/home_page.dart';
import 'package:alamuti/app/ui/onboard/onboard.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

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
          return waitingView();
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

Scaffold waitingView() {
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
                color: Color.fromRGBO(189, 121, 97, 1),
              )
            ],
          ),
        ),
      )
    ],
  ));
}
