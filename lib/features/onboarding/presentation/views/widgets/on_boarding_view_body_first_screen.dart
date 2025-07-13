import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/utils/dimensions.dart';
import 'package:graduationproject/generated/l10n.dart';

class OnBoardingViewBodyFirstScreen extends StatelessWidget {
  const OnBoardingViewBodyFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GuideScreen(
      currentPage: 0,
      assetImage: Image.asset(
        AssetsPath.onboardingImagesImg,
        width: double.infinity,
        fit: BoxFit.contain, // تغيير إلى contain
      ),
      customizedBoxDecoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(Dimensions.borderRadiusXXLarge), // 100px متجاوب
        ),
      ),
      description: S.of(context).first_page_description,
      descriptionTextStyle: AppStyles.text20SemiBold,
      title: S.of(context).first_page_title,
      text24SemiBold: AppStyles.text25Bold,
    );
  }
}