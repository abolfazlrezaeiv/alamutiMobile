import 'package:alamuti/app/ui/widgets/alamuti_textfield.dart';
import 'package:alamuti/app/ui/form_interface.dart';
import 'package:flutter/material.dart';

class JobForm extends BaseAdvertisementForm {
  @override
  Widget getPriceTextField() {
    return AlamutiTextField(title: 'حقوق ماهیانه');
  }
}
