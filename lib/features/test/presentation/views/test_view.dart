import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/utils/dimensions.dart';
import 'package:graduationproject/features/test/presentation/views/select_tests.dart';
import 'package:graduationproject/generated/l10n.dart';
import '../../../home/presentation/views/NavBar.dart';

class TestView extends StatelessWidget {
  const TestView({super.key});

  static const String routeName = '/test';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  GuideScreen(
                    description: S.of(context).test_description,
                    descriptionTextStyle: AppStyles.text14Regular.copyWith(color: AppColors.textColor),
                    assetImage: Image.asset(
                      AssetsPath.onboardingImagesImg2,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                    customizedBoxDecoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(Dimensions.borderRadiusXXLarge),
                      ),
                    ),
                    title: S.of(context).start_test,
                    text24SemiBold: AppStyles.text25Bold.copyWith(color: AppColors.textColor),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Dimensions.paddingMedium),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, BottomNavBar.routeName);
                          },
                          child: AutoSizeText(
                            S.of(context).skip,
                            style: AppStyles.text16Regular,
                            minFontSize: 12,
                            stepGranularity: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.boxHeight20),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingLarge,
                  vertical: Dimensions.paddingSmall,
                ),
                child: CustomButton(
                  textStyle: AppStyles.text18Button,
                  style: AppStyles.buttonStyle,
                  onPressed: () {
                    Navigator.pushNamed(context, SelectTest.routeName);
                  },
                  text: S.of(context).lets_start,
                  backgroundColor: AppColors.secondaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}