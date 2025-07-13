import 'package:flutter/material.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/dimensions.dart';

class CommentSkeleton extends StatelessWidget {
  const CommentSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.boxHeight6),
      child: Container(
        padding: EdgeInsets.all(Dimensions.paddingMedium),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium),
          border: Border.all(color: AppColors.greyLightColor, width: Dimensions.borderWidth05),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: Dimensions.avatarRadiusSmall,
              backgroundColor: AppColors.greyColor.withOpacity(0.1),
            ),
            SizedBox(width: Dimensions.boxWidth10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingMedium,
                      vertical: Dimensions.boxHeight8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.greyLightColor.withOpacity(0.2),
                      borderRadius:
                      BorderRadius.circular(Dimensions.borderRadiusMedium),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: Dimensions.boxWidth100,
                          height: Dimensions.boxHeight14,
                          color: AppColors.greyLightColor,
                        ),
                        SizedBox(height: Dimensions.boxHeight6),
                        Container(
                          width: double.infinity,
                          height: Dimensions.boxHeight14,
                          color: AppColors.greyLightColor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Dimensions.boxHeight6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: Dimensions.boxWidth60,
                        height: Dimensions.boxHeight11,
                        color: AppColors.greyLightColor,
                      ),
                      SizedBox(width: Dimensions.boxWidth16),
                      Icon(
                        Icons.thumb_up_alt_outlined,
                        size: Dimensions.iconSizeSmall,
                        color: AppColors.greyLightColor,
                      ),
                      SizedBox(width: Dimensions.boxWidth4),
                      Container(
                        width: Dimensions.boxWidth20,
                        height: Dimensions.boxHeight11,
                        color: AppColors.greyLightColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}