import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/utils/dimensions.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({super.key, required this.assetPath, required this.onTap});

  final String assetPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        assetPath,
        width: Dimensions.socialIconSize, // 24px متجاوب
        height: Dimensions.socialIconSize, // 24px متجاوب
      ),
    );
  }
}