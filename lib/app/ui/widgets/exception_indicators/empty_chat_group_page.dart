import 'package:flutter/material.dart';
import 'exception_indicator.dart';

/// Indicates that no items were found.
class EmptyChatGroupIndicator extends StatelessWidget {
  const EmptyChatGroupIndicator({
    required this.onTryAgain,
  });
  final VoidCallback onTryAgain;
  @override
  Widget build(BuildContext context) => ExceptionIndicator(
        title: '',
        message: 'لیست پیامها خالی است',
        assetName: 'assets/3.0x/empty-box.png',
        buttonTitle: '',
        onTryAgain: onTryAgain,
      );
}
