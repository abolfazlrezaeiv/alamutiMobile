import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Basic layout for indicating that an exception occurred.
class ExceptionIndicator extends StatelessWidget {
  const ExceptionIndicator({
    required this.title,
    required this.assetName,
    required this.message,
    required this.onTryAgain,
    required this.buttonTitle,
  });
  final String title;
  final String message;
  final String assetName;
  final String buttonTitle;
  final VoidCallback onTryAgain;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Image.asset(assetName, height: Get.height / 8),
              const SizedBox(
                height: 25,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(
                height: Get.height / 40,
              ),
              Text(
                message,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Get.height / 40,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onTryAgain,
                  child: Text(
                    this.buttonTitle,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
