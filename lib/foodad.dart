import 'package:alamuti/add_ads_category_page.dart';
import 'package:alamuti/alamuti_textfield.dart';
import 'package:alamuti/photo_card.dart';
import 'package:alamuti/submit_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_ads_photo_card.dart';
import 'alamuti_appbar.dart';
import 'description_textfield.dart';

class FoodAdForm extends StatelessWidget {
  const FoodAdForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AlamutiAppBar(
        title: 'ثبت آگهی',
        appBar: AppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 18),
        child: Form(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PhotoCard(),
                    PhotoCard(),
                    AddPhotoWidget(),
                  ],
                ),
              ),
              AlamutiTextField(title: 'عنوان آگهی'),
              AlamutiTextField(title: 'قیمت (به تومان)'),
              DescriptionTextField(),
              SubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}
