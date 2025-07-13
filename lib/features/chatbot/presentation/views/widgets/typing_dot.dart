import 'package:flutter/material.dart';
import '../../../../../core/constants/imports.dart';
import '../../../../../core/utils/dimensions.dart';

class TypingDot extends StatelessWidget {
  const TypingDot({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: Dimensions.dotSize,
      height: Dimensions.dotSize,
      decoration: BoxDecoration(
        color:  Colors.grey.withOpacity(0.6),
        shape: BoxShape.circle,
      ),
      child: const SizedBox(),
    );
  }
}