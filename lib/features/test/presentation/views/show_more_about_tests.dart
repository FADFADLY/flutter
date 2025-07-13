import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/utils/dimensions.dart';
import 'package:graduationproject/features/test/presentation/views/q_view.dart';
import 'package:graduationproject/features/test/presentation/views/select_tests.dart';
import 'package:graduationproject/generated/l10n.dart';
import '../../domain/repo/repo.dart';
import '../controller/cubits/question_cubit/questions_cubit.dart';

class ShowMoreAboutTests extends StatelessWidget {
  static const String routeName = 'show_more_about_tests';

  const ShowMoreAboutTests({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuestionsCubit(
        testRepo: getIt<TestRepository>(),
      )..getAllQuestions(),
      child: SafeArea(
        child: BlocConsumer<QuestionsCubit, QuestionsState>(
          listener: (context, state) {
            if (state is QuestionsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: AutoSizeText(
                    S.of(context).questions_error,
                    style: AppStyles.text16Regular.copyWith(color: AppColors.errorColor),
                    minFontSize: 12,
                    stepGranularity: 1,
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: buildAppBar(
                context,
                navigateTo: SelectTest.routeName,
                backgroundColor: AppColors.secondaryColor,
                title: '',
              ),
              body: state is QuestionsLoading
                  ? Center(
                child: SpinKitPumpingHeart(
                  color: AppColors.secondaryColor,
                  size: Dimensions.loadingIndicatorSize,
                  duration: const Duration(milliseconds: 1200),
                ),
              )
                  : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: Dimensions.boxHeight16),
                    AutoSizeText(
                      context.read<QuestionsCubit>().testName ?? S.of(context).tests,
                      style: AppStyles.text20Bold.copyWith(color: AppColors.textColor),
                      minFontSize: 14,
                      stepGranularity: 1,
                    ),
                    SizedBox(height: Dimensions.boxHeight16),
                    Container(
                      height: 0.8.sh,
                      width: double.infinity,
                      padding: EdgeInsets.all(Dimensions.paddingLarge),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.borderRadiusMedium),
                          topRight: Radius.circular(Dimensions.borderRadiusMedium),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText(
                            context.read<QuestionsCubit>().description ?? "",
                            style: AppStyles.text18Regular.copyWith(color: AppColors.textColor),
                            minFontSize: 12,
                            stepGranularity: 1,
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Padding(
                            padding: EdgeInsets.all(Dimensions.paddingMedium),
                            child: CustomButton(
                              textStyle: AppStyles.text18Button,
                              style: AppStyles.buttonStyle,
                              onPressed: () {
                                Navigator.pushNamed(context, QuestionsView.routeName);
                              },
                              text: S.of(context).start_test,
                              backgroundColor: AppColors.secondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}