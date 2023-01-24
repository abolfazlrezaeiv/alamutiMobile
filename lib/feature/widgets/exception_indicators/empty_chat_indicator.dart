import 'package:flutter/material.dart';
import 'exception_indicator.dart';

/// Indicates that no items were found.
class EmptyChatIndicator extends StatelessWidget {
  const EmptyChatIndicator({
    required this.onTryAgain,
  });
  final VoidCallback onTryAgain;
  @override
  Widget build(BuildContext context) => ExceptionIndicator(
        title: 'هنوز پیامی ارسال نکرده اید',
        message: '',
        assetName: 'assets/icons/messages.jpg',
        buttonTitle: '',
        onTryAgain: onTryAgain,
      );
}
