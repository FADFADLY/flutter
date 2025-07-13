import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/utils/dimensions.dart';
import 'package:graduationproject/features/test/presentation/controller/cubits/calculation/calculation_cubit.dart';
import 'package:graduationproject/features/test/presentation/views/select_tests.dart';
import 'package:graduationproject/features/test/presentation/views/widgets/buttons_row.dart';
import 'package:graduationproject/features/test/presentation/views/widgets/page_view_builder.dart';
import 'package:graduationproject/generated/l10n.dart';
import '../../../../core/shared_widgets/loading_widget.dart';
import '../../domain/repo/repo.dart';
import '../controller/cubits/question_cubit/questions_cubit.dart';

class QuestionsView extends StatelessWidget {
  const QuestionsView({super.key});

  static const String routeName = '/questions';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => QuestionsCubit(testRepo: getIt<TestRepository>())..getAllQuestions(),
        ),
        BlocProvider(
          create: (context) => CalculationCubit(testRepo: getIt<TestRepository>()),
        ),
      ],
      child: Scaffold(
        appBar: buildAppBar(
          context,
          navigateTo: SelectTest.routeName,
          backgroundColor: AppColors.secondaryColor,
          title: '',
        ),
        body: BlocConsumer<QuestionsCubit, QuestionsState>(
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
            final cubit = context.read<QuestionsCubit>();
            return SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSmall),
                    child: AutoSizeText(
                      cubit.testName ?? S.of(context).tests,
                      style: AppStyles.text20Bold.copyWith(color: AppColors.textColor),
                      minFontSize: 14,
                      stepGranularity: 1,
                    ),
                  ),
                  Expanded(
                    child: state is QuestionsLoading
                        ? const LoadingWidget()
                        : state is QuestionsError
                        ? Center(
                      child: AutoSizeText(
                        S.of(context).error_fetching_questions,
                        style: AppStyles.text18Regular.copyWith(color: AppColors.errorColor),
                        minFontSize: 12,
                        stepGranularity: 1,
                      ),
                    )
                        : cubit.groupedQuestions.isEmpty
                        ? Center(
                      child: AutoSizeText(
                        S.of(context).no_questions_available,
                        style: AppStyles.text18Regular.copyWith(color: AppColors.textColor),
                        minFontSize: 12,
                        stepGranularity: 1,
                      ),
                    )
                        : PageViewBuilder(cubit: cubit),
                  ),
                  BlocBuilder<QuestionsCubit, QuestionsState>(
                    buildWhen: (previous, current) =>
                    current is UpdatePageState || current is UpdateSelectedAnswer || current is QuestionsSuccess,
                    builder: (context, state) {
                      return Buttons(cubit: cubit);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}