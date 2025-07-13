import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/utils/dimensions.dart';
import '../../../../../core/constants/strings.dart';
import '../../../../../generated/l10n.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignInCubit>();
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
                  padding: EdgeInsets.all(Dimensions.paddingExtraLarge), // 24px متجاوب
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(Dimensions.borderRadiusLarge), // 45px متجاوب
                    ),
                  ),
                  child: BlocBuilder<SignInCubit, SignInState>(
                    builder: (context, state) {
                      return Form(
                        key: cubit.formKey,
                        autovalidateMode: cubit.autoValidateMode,
                        child: Column(
                          children: [
                            AutoSizeText(
                              minFontSize: 0,
                              S.of(context).sign_in,
                              style: AppStyles.text21Bold, // ريسبونسيف
                            ),
                            SizedBox(height: Dimensions.boxHeight20), // 20px متجاوب
                            SizedBox(
                              height: Dimensions.fieldHeight, // 60px متجاوب
                              child: CustomTextFormField(
                                controller: cubit.emailController,
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: AppColors.secondaryColor,
                                  size: Dimensions.iconSize, // 24px متجاوب
                                ),
                                hintText: S.of(context).enter_email,
                                textInputType: TextInputType.emailAddress,
                              ),
                            ),
                            SizedBox(height: Dimensions.boxHeight20), // 20px متجاوب
                            CustomTextFormField(
                              hintText: S.of(context).password,
                              controller: cubit.passwordController,
                              prefixIcon: Icon(
                                Icons.lock,
                                color: AppColors.secondaryColor,
                                size: Dimensions.iconSize, // 24px متجاوب
                              ),
                              isPasswordField: true,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      Strings.forgetPasswordViewRoute,
                                    );
                                  },
                                  child: AutoSizeText(
                                    minFontSize: 0,
                                    S.of(context).forgot_password,
                                    style: AppStyles.text16Link,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.loginButtonHeight), // 150px متجاوب
                            SizedBox(
                              width: Dimensions.buttonWidth, // 157px متجاوب
                              child: CustomButton(
                                textStyle: AppStyles.text18Button,
                                style: AppStyles.buttonStyle,
                                onPressed: () {
                                  cubit.login(context: context);
                                },
                                text: S.of(context).sign_in,
                                backgroundColor: AppColors.secondaryColor,
                              ),
                            ),
                            SizedBox(height: Dimensions.boxHeight20), // 20px متجاوب
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                AutoSizeText(
                                  minFontSize: 0,
                                  S.of(context).no_account,
                                  style: AppStyles.text14Regular,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      Strings.registerViewRoute,
                                    );
                                  },
                                  child: AutoSizeText(
                                    minFontSize: 0,
                                    S.of(context).create_one,
                                    style: AppStyles.text16Link,
                                  ),
                                ),
                              ],
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