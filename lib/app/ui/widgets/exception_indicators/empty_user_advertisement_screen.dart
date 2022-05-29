import 'package:alamuti/app/ui/widgets/exception_indicators/empty_indicator.dart';
import 'package:flutter/material.dart';
import 'exception_indicator.dart';

/// Indicates that no items were found.
class EmptyUserAdsScreenIndicator extends StatelessWidget {
  const EmptyUserAdsScreenIndicator({
    required this.onTryAgain,
  });
  final VoidCallback onTryAgain;
  @override
  Widget build(BuildContext context) => EmptyIndicator(
        title: '',
        message: '',
        assetName: 'assets/icons/search-empty.jpg',
      );
}
