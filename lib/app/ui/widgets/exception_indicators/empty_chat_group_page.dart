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
        title: 'لیست پیامها خالی است',
        message: '',
        assetName: 'assets/icons/messages.jpg',
        buttonTitle: '',
        onTryAgain: onTryAgain,
      );
}
