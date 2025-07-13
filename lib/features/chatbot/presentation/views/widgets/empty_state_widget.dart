import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:graduationproject/core/constants/imports.dart';

class EmptyStateWidget extends StatelessWidget {
  final String message;

  const EmptyStateWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AutoSizeText(
        minFontSize: 0,
        message,
        style: AppStyles.text16Regular,
      ),
    );
  }
}