import 'package:flutter/material.dart';
import 'widgets/add_ads_photo_card.dart';
import 'widgets/alamuti_appbar.dart';
import 'widgets/alamuti_textfield.dart';
import 'widgets/description_textfield.dart';
import 'widgets/photo_card.dart';
import 'widgets/submit_button.dart';

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
