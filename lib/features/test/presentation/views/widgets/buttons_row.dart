import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduationproject/features/test/presentation/views/result_view.dart';
import 'package:graduationproject/generated/l10n.dart';
import '../../../../../core/constants/imports.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../home/presentation/views/NavBar.dart';
import '../../controller/cubits/question_cubit/questions_cubit.dart';

class Buttons extends StatelessWidget {
  const Buttons({
    super.key,
    required this.cubit,
  });

  final QuestionsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingLarge,
        vertical: Dimensions.paddingSmall,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (cubit.currentPage > 0)
            SizedBox(
              width: 0.25.sw,
              child: CustomButton(
                onPressed: () {
                  cubit.goToPreviousPage();
                },
                text: S.of(context).previous,
                backgroundColor: AppColors.primaryColor,
                style: AppStyles.buttonStyle2,
                textStyle: AppStyles.text18Button,
              ),
            )
          else
             SizedBox(width: 0.25.sw),
          if (cubit.currentPage < cubit.totalPages)
            SizedBox(
              width: 0.25.sw,
              child: CustomButton(
                onPressed: cubit.canGoToNextPage()
                    ? () {
                  cubit.goToNextPage();
                }
                    : null,
                text: S.of(context).next,
                backgroundColor: AppColors.primaryColor,
                style: AppStyles.buttonStyle2,
                textStyle: AppStyles.text18Button,
              ),
            )
          else
            SizedBox(
              width: 0.25.sw,
              child: CustomButton(
                onPressed: () {
                  Navigator.pushNamed(context, BottomNavBar.routeName);
                },
                text: S.of(context).home,
                backgroundColor: AppColors.primaryColor,
                style: AppStyles.buttonStyle2,
                textStyle: AppStyles.text18Button,
              ),
            ),
        ],
      ),
    );
  }
}