import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/utils/dimensions.dart';
import '../../generated/l10n.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.textInputType = TextInputType.text,
    this.suffixIcon,
    this.onSaved,
    this.onChanged,
    this.obscureText = false,
    this.prefixIcon,
    this.isPasswordField = false,
    this.validator,
    this.enableShowHidePassword = true,
    this.width,
    this.height,
    this.textAlignVertical,
    this.borderRadius,
    this.onTap,
  });

  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onChanged;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final TextAlignVertical? textAlignVertical;
  final Widget? prefixIcon;
  final void Function(String?)? onSaved;
  final bool obscureText;
  final bool isPasswordField;
  final bool enableShowHidePassword;
  final String? Function(String?)? validator;
  final double? width;
  final double? height;
  final void Function()? onTap;
  final double? borderRadius;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final bool isMultiline = !widget.isPasswordField && !widget.obscureText;
    final double borderRadiusValue =
        widget.borderRadius ?? Dimensions.borderRadiusXLarge;

    return Container(
      height: widget.height ?? Dimensions.fieldHeight,
      width: widget.width ?? double.infinity,
      child: TextFormField(
        onTap: widget.onTap,
        textAlignVertical:
        widget.textAlignVertical ?? TextAlignVertical.center,
        maxLines: isMultiline ? null : 1,
        expands: isMultiline,
        controller: widget.controller,
        obscureText: widget.isPasswordField ? _obscureText : widget.obscureText,
        onChanged: widget.onChanged,
        onSaved: widget.onSaved,
        validator: widget.validator ??
                (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).this_field_is_required;
              }
              return null;
            },
        keyboardType: widget.textInputType,
        decoration: InputDecoration(
          isDense: true,
          errorStyle: const TextStyle(height: 0, fontSize: 0),
          suffixIcon: _buildSuffixIcon(),
          prefixIcon: widget.prefixIcon != null
              ? SizedBox(
            width: Dimensions.fieldHeight * 0.3,
            child: IconTheme(
              data: IconThemeData(
                size: Dimensions.iconSize,
              ),
              child: widget.prefixIcon!,
            ),
          )
              : null,
          contentPadding: EdgeInsets.symmetric(
            vertical: Dimensions.paddingSmall,
            horizontal: Dimensions.paddingMedium,
          ),
          hintStyle: AppStyles.text14Hint,
          hintText: widget.hintText,
          filled: true,
          fillColor: const Color(0xFFF9FAFA),
          border: _buildBorder(borderRadiusValue),
          enabledBorder: _buildBorder(borderRadiusValue),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.secondaryColor,
              width: 2.w,
            ),
            borderRadius: BorderRadius.circular(borderRadiusValue),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 1.w,
            ),
            borderRadius: BorderRadius.circular(borderRadiusValue),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.secondaryColor,
              width: 2.w,
            ),
            borderRadius: BorderRadius.circular(borderRadiusValue),
          ),
        ),
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.isPasswordField && widget.enableShowHidePassword) {
      return SizedBox(
        width: Dimensions.fieldHeight * 0.3,
        child: IconTheme(
          data: IconThemeData(
            size: Dimensions.iconSize,
          ),
          child: GestureDetector(
            onTap: _togglePasswordVisibility,
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: AppColors.secondaryColor,
            ),
          ),
        ),
      );
    }
    return widget.suffixIcon;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  OutlineInputBorder _buildBorder(double borderRadius) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: const BorderSide(
        color: Colors.grey,
      ),
    );
  }
}

