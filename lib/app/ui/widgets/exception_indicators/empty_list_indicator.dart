import 'package:alamuti/app/ui/widgets/exception_indicators/empty_indicator.dart';
import 'package:flutter/material.dart';
import 'exception_indicator.dart';

/// Indicates that no items were found.
class EmptyListIndicator extends StatelessWidget {
  const EmptyListIndicator({
    required this.onTryAgain,
  });
  final VoidCallback onTryAgain;
  @override
  Widget build(BuildContext context) => EmptyIndicator(
        title: 'آگهی یافت نشد',
        message: 'کلیدواژه ی دیگری را جستجو کنید تا نتایج بهتری بگیرید',
        assetName: 'assets/icons/search-empty.jpg',
      );
}
