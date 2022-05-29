import 'package:alamuti/app/ui/widgets/exception_indicators/empty_indicator.dart';
import 'package:alamuti/app/ui/widgets/exception_indicators/exception_indicator.dart';
import 'package:flutter/cupertino.dart';

/// Indicates that an unknown error occurred.
class GenericErrorIndicator extends StatelessWidget {
  const GenericErrorIndicator({
    required this.onTryAgain,
  });

  final VoidCallback onTryAgain;

  @override
  Widget build(BuildContext context) => EmptyIndicator(
        title: 'ارتباط برقرار نشد',
        message: 'لطفا اتصال به اینترنت دستگاه خود را بررسی کنید',
        assetName: 'assets/icons/no-connection.jpg',
      );
}
