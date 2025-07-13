import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/utils/dimensions.dart';
import 'package:graduationproject/features/test/presentation/views/widgets/question_and_answer_builder.dart';
import 'package:graduationproject/generated/l10n.dart';
import '../../../../../core/shared_widgets/loading_widget.dart';
import '../../controller/cubits/calculation/calculation_cubit.dart';
import '../../controller/cubits/question_cubit/questions_cubit.dart';
import '../q_view.dart';

class PageViewBuilder extends StatelessWidget {
  const PageViewBuilder({
    super.key,
    required this.cubit,
  });

  final QuestionsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: cubit.currentPage,
      children: List.generate(
        cubit.totalPages + 1,
            (pageIndex) {
          if (pageIndex == cubit.totalPages) {
            context.read<CalculationCubit>().calculate(
              context.read<QuestionsCubit>().answers,
            );
            return BlocBuilder<CalculationCubit, CalculationState>(
              buildWhen: (previous, current) =>
              current is CalculationLoading || current is CalculationLoaded,
              builder: (context, state) {
                return Container(
                  padding: EdgeInsets.all(Dimensions.paddingLarge),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.borderRadiusMedium),
                      topRight: Radius.circular(Dimensions.borderRadiusMedium),
                    ),
                  ),
                  child: state is CalculationLoaded
                      ? Center(
                    child: Column(
                      children: [
                        SvgPicture.network(
                          width: 0.8.sw,
                          height: 0.3.sh,
                          state.calculationDataEntity.image,
                        ),
                        SizedBox(height: Dimensions.boxHeight20),
                        AutoSizeText(
                          "${state.calculationDataEntity.score.toString()}",
                          style: AppStyles.text25Bold.copyWith(color: AppColors.secondaryColor),
                          minFontSize: 14,
                          stepGranularity: 1,
                        ),
                        SizedBox(height: Dimensions.boxHeight20),
                        AutoSizeText(
                          state.calculationDataEntity.result,
                          style: AppStyles.text20SemiBold,
                          minFontSize: 12,
                          stepGranularity: 1,
                        ),
                        SizedBox(height: Dimensions.boxHeight20),
                        AutoSizeText(
                          state.calculationDataEntity.message,
                          style: AppStyles.text16Regular,
                          minFontSize: 12,
                          stepGranularity: 1,
                          maxLines: 4,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                      : const LoadingWidget(),
                );
              },
            );
          } else {
            return Container(
              padding: EdgeInsets.all(Dimensions.paddingLarge),
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.borderRadiusMedium),
                  topRight: Radius.circular(Dimensions.borderRadiusMedium),
                ),
              ),
              child: QuestionAndAnswersBuilder(
                cubit: cubit,
                pageIndex: pageIndex,
              ),
            );
          }
        },
      ),
    );
  }
}