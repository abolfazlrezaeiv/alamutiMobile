import 'package:flutter/material.dart';
import 'exception_indicator.dart';

/// Indicates that no items were found.
class EmptyUserAdsScreenIndicator extends StatelessWidget {
  const EmptyUserAdsScreenIndicator({
    required this.onTryAgain,
  });
  final VoidCallback onTryAgain;
  @override
  Widget build(BuildContext context) => ExceptionIndicator(
        title: 'لیست آگهی های شما خالی است',
        message: 'جهت ثبت آگهی به صفحه ثبت آگهی بروید',
        assetName: 'assets/3.0x/empty-box.png',
        buttonTitle: '',
        onTryAgain: onTryAgain,
      );
}
