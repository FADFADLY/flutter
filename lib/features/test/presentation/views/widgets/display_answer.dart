import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/generated/l10n.dart';
import '../../controller/cubits/question_cubit/questions_cubit.dart';

class DisplayAnswers extends StatelessWidget {
  const DisplayAnswers({
    super.key,
    required this.answers,
    required this.selectedAnswer,
    required this.cubit,
    required this.questionIndex,
  });

  final List<String> answers;
  final String? selectedAnswer;
  final QuestionsCubit cubit;
  final int questionIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: answers.map((answer) {
        return RadioListTile<String>(
          title: AutoSizeText(
            answer,
            style: AppStyles.text16Regular,
            textAlign: TextAlign.right,
            minFontSize: 12,
            stepGranularity: 1,
          ),
          value: answer,
          groupValue: selectedAnswer,
          onChanged: (value) {
            cubit.selectAnswer(questionIndex, value!);
            print("Selected answer for question $questionIndex: $value");
          },
          activeColor: AppColors.primaryColor,
        );
      }).toList(),
    );
  }
}