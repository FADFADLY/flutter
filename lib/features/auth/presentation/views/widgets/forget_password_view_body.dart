import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/utils/dimensions.dart';
import 'package:graduationproject/features/auth/presentation/controller/cubits/forget_password_cubit/enter_email_cubit.dart';
import '../../../../../generated/l10n.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EnterEmailCubit>();
    return Stack(
      children: [
        const BackgroundContainer(),
        BlocBuilder<EnterEmailCubit, EnterEmailState>(
          buildWhen: (previous, current) =>
          current is ForgetPasswordValidationState ||
              current is ForgetPasswordInitial,
          builder: (context, state) {
            return Form(
              key: cubit.formKey,
              autovalidateMode: cubit.autoValidateMode,
              child: SizedBox(
                height: 1.sh, // ارتفاع الشاشة بالكامل
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: Dimensions.topPaddingLarge), // 300px متجاوب
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(Dimensions.paddingExtraLarge), // 24px متجاوب
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(Dimensions.borderRadiusLarge), // 45px متجاوب
                          ),
                        ),
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
                              S.of(context).enter_email_to_get_code,
                              style: AppStyles.text12SemiBold, // ريسبونسيف
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: Dimensions.boxHeight20), // 20px متجاوب
                            CustomTextFormField(
                              controller: cubit.emailController,
                              prefixIcon: Icon(
                                Icons.email,
                                color: AppColors.secondaryColor,
                                size: Dimensions.iconSize, // 24px متجاوب
                              ),
                              hintText: S.of(context).enter_email,
                              textInputType: TextInputType.emailAddress,
                            ),
                            SizedBox(height: Dimensions.boxHeight300), // 300px متجاوب
                            CustomButton(
                              textStyle: AppStyles.text18Button,
                              style: AppStyles.buttonStyle,
                              onPressed: () {
                                cubit.forgetPassword(context: context);
                              },
                              text: S.of(context).confirm,
                              backgroundColor: AppColors.secondaryColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}