import 'package:alamuti/alamuti_textfield.dart';
import 'package:alamuti/form_interface.dart';
import 'package:flutter/material.dart';

class JobForm extends BaseAdvertisementForm {
  @override
  Widget getPriceTextField() {
    return AlamutiTextField(title: 'حقوق ماهیانه');
  }
}
