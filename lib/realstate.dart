import 'package:flutter/material.dart';

class AlamutRealstate extends StatelessWidget {
  const AlamutRealstate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              Card(),
              Card(),
              Card(),
              Card(),
              Card(),
              Card(),
            ],
          )
        ],
      ),
    );
  }
}
