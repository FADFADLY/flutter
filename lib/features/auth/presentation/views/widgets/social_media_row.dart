import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/utils/dimensions.dart';
import '../../../../../generated/l10n.dart';

class SocialMediaRow extends StatelessWidget {
  const SocialMediaRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSmall), // 10px متجاوب
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeText(
            minFontSize: 0,
            S.of(context).or_create_account_with,
            style: AppStyles.text16Regular.copyWith(
              color: AppColors.secondaryColor,
            ),
          ),
          // Social icons
          Row(
            children: [
              SocialMedia(
                assetPath: AssetsPath.signupFacebook,
                onTap: () {},
              ),
              SizedBox(width: Dimensions.boxHeight20), // 20px متجاوب
              SocialMedia(
                assetPath: AssetsPath.signupGoogle,
                onTap: () {},
              ),
              SizedBox(width: Dimensions.boxHeight20), // 20px متجاوب
              SocialMedia(
                assetPath: AssetsPath.signupLinkedin,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}