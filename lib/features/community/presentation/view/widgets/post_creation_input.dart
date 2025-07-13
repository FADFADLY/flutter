import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../../../core/constants/imports.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/styles.dart';
import 'create_post_view.dart';

class PostCreationInput extends StatelessWidget {
  const PostCreationInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.paddingMedium,
        left: Dimensions.paddingMedium,
        right: Dimensions.paddingMedium,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: Dimensions.avatarUserRadius,
            backgroundColor: AppColors.errorColor,
            child: Icon(Icons.person, color: AppColors.whiteColor),
          ),
          SizedBox(width: Dimensions.boxWidth12),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CreatePostView()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingMedium,
                  vertical: Dimensions.boxHeight14,
                ),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius:
                  BorderRadius.circular(Dimensions.borderRadiusMediumLarge),
                  border: Border.all(color: AppColors.secondaryColor),
                ),
                child: AutoSizeText(
                  S.of(context).what_on_your_mind,
                  style: AppStyles.text14Regular
                      .copyWith(color: AppColors.greyLightColor),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}