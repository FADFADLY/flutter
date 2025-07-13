import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/utils/dimensions.dart';
import 'package:graduationproject/features/test/presentation/views/q_view.dart';
import 'package:graduationproject/features/test/presentation/views/show_more_about_tests.dart';
import 'package:graduationproject/generated/l10n.dart';

class SelectedTestButtons extends StatelessWidget {
  const SelectedTestButtons({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(Dimensions.paddingMedium),
            child: CustomButton(
              textStyle: AppStyles.text18Button,
              style: AppStyles.buttonStyle,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pushNamed(context, QuestionsView.routeName);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: AutoSizeText(
                        S.of(context).please_select_test,
                        style: AppStyles.text14Error,
                        minFontSize: 12,
                        stepGranularity: 1,
                      ),
                    ),
                  );
                }
              },
              text: S.of(context).start_test,
              backgroundColor: AppColors.secondaryColor,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(Dimensions.paddingMedium),
            child: CustomButton(
              textStyle: AppStyles.text18Button.copyWith(
                color: AppColors.secondaryColor,
              ),
              style: AppStyles.buttonStyle.copyWith(
                backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
                side: WidgetStatePropertyAll(
                  BorderSide(color: AppColors.secondaryColor, width: 2),
                ),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pushNamed(context, ShowMoreAboutTests.routeName);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: AutoSizeText(
                        S.of(context).please_select_test,
                        style: AppStyles.text14Error,
                        minFontSize: 12,
                        stepGranularity: 1,
                      ),
                    ),
                  );
                }
              },
              text: S.of(context).learn_about_test,
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}