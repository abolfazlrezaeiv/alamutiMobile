import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Scaffold errorView(AsyncSnapshot<Object?> snapshot) {
  return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
}

Scaffold waitingView(Size mq) {
  return Scaffold(
      body: Stack(
    children: [
      Container(
        color: Color.fromRGBO(141, 235, 172, 1),
      ),
      Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo/logo.png',
                width: mq.width / 2,
              ),
              SizedBox(
                height: mq.height / 3.8,
              ),
              Text("به الموتی خوش آمدید"),
              SizedBox(
                height: 20,
              ),
              CircularProgressIndicator()
            ],
          ),
        ),
      )
    ],
  ));
}
