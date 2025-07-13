import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/utils/dimensions.dart';
import '../../../../../generated/l10n.dart';

class RegisterScreenBody extends StatefulWidget {
  const RegisterScreenBody({super.key});

  @override
  State<RegisterScreenBody> createState() => _RegisterScreenBodyState();
}

class _RegisterScreenBodyState extends State<RegisterScreenBody> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();
    return Stack(
      children: [
        const BackgroundContainer(),
        SingleChildScrollView(
          child: BlocBuilder<SignupCubit, SignupState>(
            buildWhen: (previous, current) =>
            current is SignupValidationState || current is SignupInitialState,
            builder: (context, state) {
              return Form(
                key: cubit.formKey,
                autovalidateMode: cubit.autoValidateMode,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: Dimensions.topPaddingLarge), // 300px متجاوب
                      child: Container(
                        padding: EdgeInsets.all(Dimensions.paddingMedium), // 16px متجاوب
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimensions.borderRadiusLarge), // 45px متجاوب
                            topRight: Radius.circular(Dimensions.borderRadiusLarge), // 45px متجاوب
                          ),
                        ),
                        child: Column(
                          children: [
                            AutoSizeText(
                              minFontSize: 0,
                              S.of(context).register_start,
                              style: AppStyles.text24SemiBold,
                            ),
                            SizedBox(height: Dimensions.boxHeight20), // 20px متجاوب
                            SizedBox(
                              height: Dimensions.fieldHeight, // 60px متجاوب
                              child: CustomTextFormField(
                                controller: cubit.nameController,
                                hintText: S.of(context).name,
                                onChanged: (value) {},
                                textInputType: TextInputType.name,
                              ),
                            ),
                            SizedBox(height: Dimensions.boxHeight16), // 16px متجاوب
                            SizedBox(
                              height: Dimensions.fieldHeight, // 60px متجاوب
                              child: CustomTextFormField(
                                controller: cubit.displayNameController,
                                hintText: S.of(context).display_name,
                                onChanged: (value) {},
                                textInputType: TextInputType.name,
                              ),
                            ),
                            SizedBox(height: Dimensions.boxHeight16), // 16px متجاوب
                            BlocBuilder<SignupCubit, SignupState>(
                              buildWhen: (previous, current) =>
                              current is SignupGenderUpdatedState,
                              builder: (context, state) {
                                return CustomDropdown(
                                  items: cubit.genders,
                                  onChanged: (value) {
                                    cubit.updateGender(value);
                                  },
                                  hintText: S.of(context).gender,
                                  selectedValue: cubit.selectedGender,
                                );
                              },
                            ),
                            SizedBox(height: Dimensions.boxHeight16), // 16px متجاوب
                            SizedBox(
                              height: Dimensions.fieldHeight, // 60px متجاوب
                              child: CustomTextFormField(
                                controller: cubit.ageController,
                                hintText: S.of(context).age,
                                onChanged: (value) {},
                                textInputType: TextInputType.number,
                              ),
                            ),
                            SizedBox(height: Dimensions.boxHeight16), // 16px متجاوب
                            SizedBox(
                              height: Dimensions.fieldHeight, // 60px متجاوب
                              child: CustomTextFormField(
                                controller: cubit.emailController,
                                hintText: S.of(context).email,
                                onChanged: (value) {},
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return S.of(context).enter_email;
                                  }
                                  final emailRegex = RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                  if (!emailRegex.hasMatch(value)) {
                                    return S.of(context).enter_valid_email;
                                  }
                                  return null;
                                },
                                textInputType: TextInputType.emailAddress,
                              ),
                            ),
                            SizedBox(height: Dimensions.boxHeight16), // 16px متجاوب
                            SizedBox(
                              height: Dimensions.fieldHeight, // 60px متجاوب
                              child: CustomTextFormField(
                                isPasswordField: true,
                                controller: cubit.passwordController,
                                onChanged: (value) {},
                                hintText: S.of(context).password,
                              ),
                            ),
                            SizedBox(height: Dimensions.boxHeight16), // 16px متجاوب
                            SizedBox(
                              height: Dimensions.fieldHeight, // 60px متجاوب
                              child: CustomTextFormField(
                                isPasswordField: true,
                                hintText: S.of(context).confirm_password,
                                controller: cubit.confirmPasswordController,
                                onChanged: (value) {},
                              ),
                            ),
                            SizedBox(height: Dimensions.boxHeight16), // 16px متجاوب
                            CustomButton(
                              textStyle: AppStyles.text18Button,
                              style: AppStyles.buttonStyle,
                              onPressed: () {
                                cubit.registerUser(context: context);
                              },
                              text: S.of(context).create_account,
                              backgroundColor: AppColors.primaryColor,
                            ),
                            SizedBox(height: Dimensions.boxHeight26), // 26px متجاوب
                            const SocialMediaRow(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}