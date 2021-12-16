import 'dart:io';

import 'package:alamuti/app/controller/authentication_manager.dart';
import 'package:alamuti/app/ui/Login/login.dart';

import 'package:alamuti/app/ui/Login/register.dart';
import 'package:alamuti/app/ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationManager _authManager = Get.put(AuthenticationManager());

    return _authManager.checkLoginStatus() ? HomePage() : Registeration();
  }
}
