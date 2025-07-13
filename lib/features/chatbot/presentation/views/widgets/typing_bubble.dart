import 'package:flutter/material.dart';
import 'package:graduationproject/features/chatbot/presentation/views/widgets/typing_dot.dart';
import '../../../../../core/constants/imports.dart';
import '../../../../../core/utils/dimensions.dart';

class TypingBubble extends StatelessWidget {
  const TypingBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: Dimensions.paddingSmall, horizontal: Dimensions.paddingMedium),
        padding: EdgeInsets.all(Dimensions.paddingMedium),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium).copyWith(
            topLeft: const Radius.circular(0),
            topRight:  Radius.circular(Dimensions.borderRadiusMedium),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TypingDot(),
            SizedBox(width: 4),
            TypingDot(),
            SizedBox(width: 4),
            TypingDot(),
          ],
        ),
      ),
    );
  }
}