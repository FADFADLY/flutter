import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/utils/dimensions.dart';

class BackgroundContainer extends StatelessWidget {
  const BackgroundContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.topPaddingBackground, // 350px متجاوب
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
      ),
      child: SvgPicture.asset(
        AssetsPath.loginScreenBackground,
        width: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}