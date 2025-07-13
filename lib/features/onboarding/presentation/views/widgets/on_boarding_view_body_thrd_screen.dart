import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/utils/dimensions.dart';
import 'package:graduationproject/generated/l10n.dart';

class OnBoardingViewBodyThrdScreen extends StatelessWidget {
  const OnBoardingViewBodyThrdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GuideScreen(
      currentPage: 2,
      title: S.of(context).third_page_title,
      description: S.of(context).third_page_description,
      descriptionTextStyle: AppStyles.text20SemiBold,
      text24SemiBold: AppStyles.text25Bold,
      assetImage: Image.asset(
        AssetsPath.onboardingImagesImg2,
        width: double.infinity,
        fit: BoxFit.contain,
      ),
      customizedBoxDecoration: const BoxDecoration(
        color: AppColors.backgroundColor,
      ),
    );
  }
}