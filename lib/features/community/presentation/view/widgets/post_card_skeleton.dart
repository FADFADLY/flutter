import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/dimensions.dart';

class PostCardSkeleton extends StatelessWidget {
  const PostCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(bottom: Dimensions.boxHeight8),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingMedium,
              vertical: Dimensions.paddingMedium,
            ),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(Dimensions.borderRadiusMediumLarge),
              border: Border.all(color: AppColors.greyLightColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(radius: Dimensions.avatarUserRadius),
                    SizedBox(width: Dimensions.boxWidth10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: Dimensions.boxWidth100,
                          height: Dimensions.boxHeight10,
                          color: AppColors.greyLightColor,
                        ),
                        SizedBox(height: Dimensions.boxHeight4),
                        Container(
                          width: Dimensions.boxWidth60,
                          height: Dimensions.boxHeight8,
                          color: AppColors.greyLightColor,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.boxHeight12),
                Container(
                  height: Dimensions.boxHeight10,
                  width: double.infinity,
                  color: AppColors.greyLightColor,
                ),
                SizedBox(height: Dimensions.boxHeight6),
                Container(
                  height: Dimensions.boxHeight10,
                  width: MediaQuery.of(context).size.width * 0.7,
                  color: AppColors.greyLightColor,
                ),
                SizedBox(height: Dimensions.boxHeight12),
                Container(
                  height: Dimensions.boxHeight180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.greyLightColor,
                    borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                  ),
                ),
                SizedBox(height: Dimensions.boxHeight12),
                Row(
                  children: [
                    Icon(
                      Icons.thumb_up_alt_outlined,
                      size: Dimensions.iconSize,
                      color: AppColors.greyLightColor,
                    ),
                    SizedBox(width: Dimensions.boxWidth8),
                    Container(
                      width: Dimensions.boxWidth20,
                      height: Dimensions.boxHeight8,
                      color: AppColors.greyLightColor,
                    ),
                    SizedBox(width: Dimensions.boxWidth16),
                    Icon(
                      Icons.comment,
                      size: Dimensions.iconSize,
                      color: AppColors.greyLightColor,
                    ),
                    SizedBox(width: Dimensions.boxWidth8),
                    Container(
                      width: Dimensions.boxWidth20,
                      height: Dimensions.boxHeight8,
                      color: AppColors.greyLightColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}