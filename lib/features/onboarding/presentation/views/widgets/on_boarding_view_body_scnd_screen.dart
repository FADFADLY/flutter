import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/utils/dimensions.dart';
import 'package:graduationproject/generated/l10n.dart';

class OnBoardingViewBodyScndScreen extends StatelessWidget {
  const OnBoardingViewBodyScndScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GuideScreen(
      currentPage: 1,
      title: S.of(context).second_page_title,
      description: S.of(context).second_page_description,
      descriptionTextStyle: AppStyles.text20SemiBold,
      text24SemiBold: AppStyles.text25Bold,
      assetImage: Image.asset(
        AssetsPath.onboardingImagesImg2,
        width: double.infinity,
        fit: BoxFit.contain, // رجّعنا للأصلي
      ),
      customizedBoxDecoration: const BoxDecoration(
        color: AppColors.backgroundColor,
      ),
    );
  }
}