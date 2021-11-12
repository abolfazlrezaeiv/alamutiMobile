import 'package:alamuti/photo_card.dart';
import 'package:alamuti/submit_button.dart';
import 'package:flutter/material.dart';

import 'add_ads_photo_card.dart';
import 'alamuti_appbar.dart';
import 'alamuti_textfield.dart';
import 'description_textfield.dart';

class BaseAdvertisementForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AlamutiAppBar(
        title: 'ثبت آگهی',
        hasBackButton: true,
        appBar: AppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23.0),
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
              getPriceTextField(),
              getAreaTextField(),
              DescriptionTextField(),
              SubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getAreaTextField() {
    return Container();
  }

  Widget getPriceTextField() {
    return AlamutiTextField(title: 'قیمت (به تومان)');
  }
}
