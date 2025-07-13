import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/constants/sensitive_strings.dart';
import '../../../../data/models/forget_password/email_request.dart';
import '../../../../data/models/forget_password/email_response.dart';

part 'enter_email_state.dart';

class EnterEmailCubit extends Cubit<EnterEmailState> {
  EnterEmailCubit({required this.authRepo})
      : super(ForgetPasswordInitial());
  final AuthRepo authRepo;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  Future<void> forgetPassword({required BuildContext context}) async {
    autoValidateMode = AutovalidateMode.always;
    emit(ForgetPasswordValidationState());

    if (!formKey.currentState!.validate()) {
      return;
    }

    formKey.currentState!.save();

    emit(ForgetPasswordLoadingState());
    final result = await authRepo.forgetPassword(
        forgetPasswordRequest: ForgetPasswordRequest(email: emailController.text));
    result.fold(
          (failure) {
        emit(ForgetPasswordFailureState(message: failure.message));
      },
          (success) {
        CacheHelper.set(key: SensitiveStrings.resetPasswordEmailKey, value: emailController.text);
        emit(ForgetPasswordSuccessState());
      },
    );
  }

  @override
  Future<void> close() async {
    emailController.dispose();
    await super.close();
  }
}