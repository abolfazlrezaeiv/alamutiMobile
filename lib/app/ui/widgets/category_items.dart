import 'package:alamuti/app/controller/adsFormController.dart';
import 'package:flutter/material.dart';
import '../category.dart';

var categoryItems = <CategoryItem>[
  CategoryItem(
      icon: Icons.shopping_basket,
      title: 'مواد غذایی',
      state: AdsFormState.FOOD),
  CategoryItem(
      icon: Icons.engineering, title: 'کسب و کار', state: AdsFormState.JOB),
  CategoryItem(
      icon: Icons.home_work, title: 'املاک', state: AdsFormState.REALSTATE),
];
