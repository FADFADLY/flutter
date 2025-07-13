import 'package:flutter/material.dart';
import '../../../../../../core/constants/imports.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../models/grid_item_model.dart';

class GridItemWidget extends StatelessWidget {
  final GridItem item;

  const GridItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusMediumLarge),
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding:  EdgeInsets.all(Dimensions.paddingMedium),
              child: Image.asset(
                item.imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            height: Dimensions.boxHeight40,
            width: Dimensions.buttonWidth,
            child: CustomButton(
              text: item.title,
              onPressed: item.onPressed,
              backgroundColor: AppColors.secondaryColor,
              style: AppStyles.buttonStyle,
              textStyle: AppStyles.text18Button,
            ),
          ),
        ],
      ),
    );
  }
}