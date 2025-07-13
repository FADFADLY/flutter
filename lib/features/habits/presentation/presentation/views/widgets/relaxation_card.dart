import 'package:flutter/material.dart';
import 'package:graduationproject/core/constants/imports.dart';

import '../../../../../../core/utils/dimensions.dart';

class RelaxationCard extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final String assetsPath;

  const RelaxationCard({
    super.key,
    required this.title,
    this.onTap,
    required this.assetsPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: AppColors.backgroundColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.borderRadiusMediumLarge)), // 30.r
        child: Padding(
          padding: EdgeInsets.all(Dimensions.paddingMedium), // 16.w
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.12,
                child: SvgPicture.asset(
                  fit: BoxFit.cover,
                  assetsPath,
                ),
              ),
              SizedBox(width: Dimensions.boxHeight16), // 16.w
              Expanded(
                child: Text(
                  title,
                  style: AppStyles.text16SemiBold,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}