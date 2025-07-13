import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/utils/dimensions.dart';
import 'package:graduationproject/features/test/presentation/views/q_view.dart';
import 'package:graduationproject/generated/l10n.dart';
import '../../domain/repo/repo.dart';
import '../controller/cubits/calculation/calculation_cubit.dart';
import '../controller/cubits/question_cubit/questions_cubit.dart';

class ResultView extends StatelessWidget {
  const ResultView({super.key});

  static const String routeName = '/result';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: S.of(context).test_result,
        navigateTo: QuestionsView.routeName,
        backgroundColor: AppColors.secondaryColor,
      ),
      body: Center(
        child: BlocBuilder<CalculationCubit, CalculationState>(
          builder: (context, state) {
            if (state is CalculationLoading) {
              return CircularProgressIndicator(color: AppColors.primaryColor);
            } else if (state is CalculationLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoSizeText(
                    '${S.of(context).your_score}: ${state.calculationDataEntity.score}',
                    style: AppStyles.text32Bold.copyWith(color: AppColors.successColor),
                    minFontSize: 16,
                    stepGranularity: 1,
                  ),
                  SizedBox(height: Dimensions.boxHeight20),
                  AutoSizeText(
                    state.calculationDataEntity.result,
                    style: AppStyles.text18Regular.copyWith(color: AppColors.textColor),
                    minFontSize: 12,
                    stepGranularity: 1,
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            } else if (state is CalculationError) {
              return AutoSizeText(
                '${S.of(context).error}: ${state.message}',
                style: AppStyles.text18Regular.copyWith(color: AppColors.errorColor),
                minFontSize: 12,
                stepGranularity: 1,
              );
            }
            return AutoSizeText(
              S.of(context).please_wait,
              style: AppStyles.text18Regular.copyWith(color: AppColors.textColor),
              minFontSize: 12,
              stepGranularity: 1,
            );
          },
        ),
      ),
    );
  }
}