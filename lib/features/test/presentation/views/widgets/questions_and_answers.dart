import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/utils/dimensions.dart';
import 'package:graduationproject/generated/l10n.dart';
import '../../controller/cubits/question_cubit/questions_cubit.dart';

class QuestionAndNumber extends StatelessWidget {
  const QuestionAndNumber({
    super.key,
    required this.questionIndex,
    required this.cubit,
    required this.question,
  });

  final int questionIndex;
  final QuestionsCubit cubit;
  final String question;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AutoSizeText(
          "${questionIndex + 1}/${cubit.listOfQuestions.length}",
          style: AppStyles.text16Regular,
          minFontSize: 12,
          stepGranularity: 1,
        ),
        SizedBox(width: Dimensions.paddingMedium),
        Expanded(
          child: AutoSizeText(
            question,
            style: AppStyles.text18Bold,
            textAlign: TextAlign.right,
            minFontSize: 12,
            stepGranularity: 1,
          ),
        ),
      ],
    );
  }
}