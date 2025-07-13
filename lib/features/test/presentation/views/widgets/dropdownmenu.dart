import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/utils/dimensions.dart';
import 'package:graduationproject/generated/l10n.dart';

class DropDownMenu extends StatefulWidget {
  const DropDownMenu({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  });

  final List<String> items;
  final String selectedItem;
  final void Function(String?)? onChanged;

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingMedium),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 38.h),
            child: DropdownSearch<String>(

              validator: (value) {

                if (value == null || value.isEmpty) {
                  setState(() {
                    errorText = S.of(context).please_select_test;
                  });
                  return '';
                }
                if (!widget.items.contains(value)) {
                  setState(() {
                    errorText = S.of(context).invalid_test_selected;
                  });
                  return '';
                }
                setState(() {
                  errorText = null;
                });
                return null;
              },
              items: widget.items,
              selectedItem: widget.selectedItem.isEmpty ? null : widget.selectedItem ,

              onChanged: widget.onChanged,
              dropdownButtonProps: const DropdownButtonProps(
                icon: SizedBox.shrink(),
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                baseStyle :  AppStyles.text14Regular,
                textAlign: TextAlign.right,
                dropdownSearchDecoration: InputDecoration(
                  hintText: S.of(context).select_test,
                  hintStyle: AppStyles.text14Hint,
                  filled: true,
                  fillColor: AppColors.whiteColor,
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(right: Dimensions.paddingSmall),
                    child: Icon(
                      Icons.arrow_drop_down,
                      size: 25.sp,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium),
                    borderSide: BorderSide(
                      color: AppColors.borderColor,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium),
                    borderSide: BorderSide(
                      color: AppColors.borderColor,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium),
                    borderSide: BorderSide(
                      color: AppColors.secondaryColor,
                      width: 1,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium),
                    borderSide: BorderSide(
                      color: AppColors.errorColor,
                      width: 1,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium),
                    borderSide: BorderSide(
                      color: AppColors.errorColor,
                      width: 1,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingMedium,
                    vertical: Dimensions.paddingSmall,
                  ),
                  errorStyle: AppStyles.text14Error,
                ),
              ),
              popupProps: PopupProps.menu(
                showSelectedItems: true,
                showSearchBox: false,
                menuProps: MenuProps(
                  borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium),
                  backgroundColor: AppColors.whiteColor,
                  elevation: 4,
                ),
                constraints: BoxConstraints(
                  maxHeight: 200.h,
                  maxWidth: double.infinity,
                ),
                fit: FlexFit.loose,
                containerBuilder: (context, popupWidget) => popupWidget,
                itemBuilder: (context, item, isSelected) => Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingMedium,
                    vertical: Dimensions.paddingSmall,
                  ),
                  child: AutoSizeText(
                    item,
                    style: AppStyles.text14Regular,
                    minFontSize: 12,
                    stepGranularity: 1,
                  ),
                ),
              ),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: EdgeInsets.only(right: Dimensions.paddingLarge, top: Dimensions.paddingSmall),
            child: AutoSizeText(
              errorText!,
              style: AppStyles.text14Error,
              minFontSize: 12,
              stepGranularity: 1,
            ),
          ),
      ],
    );
  }
}