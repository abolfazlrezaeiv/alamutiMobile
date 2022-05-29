import 'package:alamuti/app/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Basic layout for indicating that an exception occurred.
class EmptyIndicator extends StatelessWidget {
  const EmptyIndicator({
    required this.title,
    required this.assetName,
    required this.message,
  });
  final String title;
  final String message;
  final String assetName;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Container(
                child: Image.asset(
                  assetName,
                  height: Get.height / 8,
                  fit: BoxFit.fill,
                ),
              ),
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
            ],
          ),
        ),
      );
}
