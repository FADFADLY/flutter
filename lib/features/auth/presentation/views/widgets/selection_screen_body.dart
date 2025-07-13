import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/utils/dimensions.dart';
import '../../../../../core/constants/strings.dart';
import '../../../../../generated/l10n.dart';

class SelectionScreenBody extends StatelessWidget {
  const SelectionScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background SVG
        Positioned.fill(
          child: SvgPicture.asset(
            AssetsPath.selectionScreenBackground,
            fit: BoxFit.cover,
          ),
        ),
        // Content
        Align(
          alignment: const Alignment(0, -0.5),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingMedium), // 16px متجاوب
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: Dimensions.buttonWidth, // 157px متجاوب
                  child: CustomButton(
                    textStyle: AppStyles.text18Button,
                    style: AppStyles.buttonStyle,
                    onPressed: () {
                      Navigator.pushNamed(context, Strings.loginViewRoute);
                    },
                    text: S.of(context).sign_in,
                    backgroundColor: AppColors.secondaryColor,
                  ),
                ),
                SizedBox(height: Dimensions.boxHeight20), // 20px متجاوب
                SizedBox(
                  width: Dimensions.buttonWidth, // 157px متجاوب
                  child: CustomButton(
                    textStyle: AppStyles.text18Button,
                    style: AppStyles.buttonStyle,
                    onPressed: () {
                      Navigator.pushNamed(context, Strings.registerViewRoute);
                    },
                    text: S.of(context).sign_up,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}