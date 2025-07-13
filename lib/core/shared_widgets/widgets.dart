import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/utils/dimensions.dart';

class GuideScreen extends StatelessWidget {
  final int currentPage;
  final String title;
  final String description;
  final TextStyle descriptionTextStyle;
  final TextStyle text24SemiBold;
  final Widget assetImage;
  final BoxDecoration customizedBoxDecoration;

  const GuideScreen({
    required this.title,
    required this.description,
    required this.descriptionTextStyle,
    required this.text24SemiBold,
    required this.assetImage,
    required this.customizedBoxDecoration,
    this.currentPage = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(Dimensions.paddingLarge), // 20px متجاوب
            width: double.infinity,
            height: 0.55.sh, // نفس النسبة الأصلية (0.55 من ارتفاع الشاشة) بس ريسبونسيف
            decoration: customizedBoxDecoration,
            child: assetImage,
          ),
          SizedBox(height: Dimensions.boxHeight30), // 30px متجاوب
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingLarge), // 20px متجاوب
            child: AutoSizeText(
              title,
              textAlign: TextAlign.center,
              style: text24SemiBold,
              maxLines: 2,
              minFontSize: 14, // مضاعف لـ stepGranularity
              stepGranularity: 1,
            ),
          ),
          SizedBox(height: Dimensions.boxHeight20), // 20px متجاوب
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingLarge), // 20px متجاوب
            child: AutoSizeText(
              description,
              textAlign: TextAlign.center,
              style: descriptionTextStyle,
              maxLines: 4,
              minFontSize: 12, // مضاعف لـ stepGranularity
              stepGranularity: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}