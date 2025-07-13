import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/utils/dimensions.dart';
import 'package:graduationproject/generated/l10n.dart';

class OnBoardingViewBodyFourthScreen extends StatelessWidget {
  const OnBoardingViewBodyFourthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GuideScreen(
      currentPage: 3,
      description: S.of(context).fourth_page_description,
      descriptionTextStyle: AppStyles.text20SemiBold,
      assetImage: Image.asset(
        AssetsPath.onboardingImagesImg3,
        width: double.infinity,
        fit: BoxFit.contain, // رجّعنا للأصلي
      ),
      customizedBoxDecoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(Dimensions.borderRadiusXXLarge), // 100px متجاوب
        ),
      ),
      title: S.of(context).fourth_page_title,
      text24SemiBold: AppStyles.text25Bold,
    );
  }
}