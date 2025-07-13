import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/utils/dimensions.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String? selectedValue;
  final Function(String?)? onChanged;
  final String hintText;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Dimensions.fieldHeight, // 60px متجاوب
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusXLarge), // 50px متجاوب
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        iconEnabledColor: AppColors.secondaryColor,
        underline: const SizedBox(),
        icon: Padding(
          padding: EdgeInsets.only(right: Dimensions.paddingMedium), // 16px متجاوب
          child: Icon(
            Icons.arrow_drop_down,
            size: Dimensions.dropdownIconSize, // 24px متجاوب
            color: AppColors.secondaryColor,
          ),
        ),
        style: AppStyles.text14Regular,
        hint: Padding(
          padding: EdgeInsets.only(left: Dimensions.paddingSmall), // 10px متجاوب
          child: AutoSizeText(
            minFontSize: 0,
            hintText,
            style: AppStyles.text14Hint, // استخدمت text14Hint للـ hint
          ),
        ),
        value: selectedValue?.isEmpty ?? true ? null : selectedValue,
        onChanged: onChanged,
        alignment: Alignment.centerLeft,
        dropdownColor: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium), // 25px متجاوب
        itemHeight: Dimensions.dropdownItemHeight, // 50px متجاوب
        menuMaxHeight: Dimensions.dropdownMenuMaxHeight, // 200px متجاوب
        items: items
            .map((e) => DropdownMenuItem<String>(
          value: e,
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingMedium), // 16px متجاوب
            child: AutoSizeText(
              minFontSize: 0,
              e,
              style: AppStyles.text14Regular,
            ),
          ),
        ))
            .toList(),
      ),
    );
  }
}