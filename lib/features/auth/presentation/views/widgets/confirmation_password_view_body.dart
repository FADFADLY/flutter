import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/utils/dimensions.dart';
import '../../../../../generated/l10n.dart';
import '../../controller/cubits/forget_password_cubit/password_confirmation_cubit.dart';

class ConfirmationPasswordViewBody extends StatefulWidget {
  const ConfirmationPasswordViewBody({super.key});

  @override
  State<ConfirmationPasswordViewBody> createState() =>
      _ConfirmationPasswordViewBodyState();
}

class _ConfirmationPasswordViewBodyState
    extends State<ConfirmationPasswordViewBody> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PasswordConfirmationCubit>();
    return Stack(
      children: [
        const BackgroundContainer(),
        SizedBox(
          height: 1.sh, // ارتفاع الشاشة بالكامل
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Dimensions.topPaddingLarge), // 300px متجاوب
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(Dimensions.paddingXXLarge), // 30px متجاوب
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(Dimensions.borderRadiusLarge), // 45px متجاوب
                    ),
                  ),
                  child: BlocBuilder<PasswordConfirmationCubit, PasswordConfirmationState>(
                    buildWhen: (previous, current) =>
                    current is PasswordConfirmationValidationState ||
                        current is PasswordConfirmationInitial,
                    builder: (context, state) {
                      return Form(
                        key: cubit.formKey,
                        autovalidateMode: cubit.autoValidateMode,
                        child: Column(
                          children: [
                            AutoSizeText(
                              minFontSize: 0,
                              S.of(context).forgot_password,
                              style: AppStyles.text21Bold, // ريسبونسيف
                            ),
                            SizedBox(height: Dimensions.boxHeight20), // 20px متجاوب
                            AutoSizeText(
                              minFontSize: 0,
                              S.of(context).new_password_instruction,
                              style: AppStyles.text12SemiBold, // ريسبونسيف
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: Dimensions.boxHeight20), // 20px متجاوب
                            CustomTextFormField(
                              hintText: S.of(context).password,
                              controller: cubit.passwordController,
                              isPasswordField: true,
                            ),
                            SizedBox(height: Dimensions.boxHeight20), // 20px متجاوب
                            CustomTextFormField(
                              hintText: S.of(context).confirm_password,
                              controller: cubit.rePasswordController,
                              isPasswordField: true,
                            ),
                            SizedBox(height: Dimensions.boxHeight214), // 214px متجاوب
                            CustomButton(
                              textStyle: AppStyles.text18Button,
                              style: AppStyles.buttonStyle,
                              onPressed: () {
                                cubit.passwordConfirmation(context: context);
                              },
                              text: S.of(context).send,
                              backgroundColor: AppColors.secondaryColor,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}