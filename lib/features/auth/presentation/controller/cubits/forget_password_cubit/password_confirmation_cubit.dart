import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:meta/meta.dart';
import 'package:graduationproject/generated/l10n.dart';
import '../../../../../../core/constants/sensitive_strings.dart';

import '../../../../data/models/forget_password/confirmation_request.dart';

part 'password_confirmation_state.dart';

class PasswordConfirmationCubit extends Cubit<PasswordConfirmationState> {
  PasswordConfirmationCubit({required this.authRepo})
      : super(PasswordConfirmationInitial());
  final AuthRepo authRepo;

  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  Future<void> passwordConfirmation({
    required BuildContext context,
  }) async {
    autoValidateMode = AutovalidateMode.always;
    emit(PasswordConfirmationValidationState());

    if (!formKey.currentState!.validate()) {
      return;
    }

    formKey.currentState!.save();

    final email = CacheHelper.getString(key: SensitiveStrings.resetPasswordEmailKey);
    if (email == null || email.isEmpty) {
      emit(PasswordConfirmationFailureState(msg: S.of(context).enter_email));
      return;
    }

    final password = passwordController.text;
    final rePassword = rePasswordController.text;

    if (password != rePassword) {
      emit(PasswordConfirmationFailureState(
          msg: S.of(context).passwords_do_not_match));
      return;
    }

    emit(PasswordConfirmationLoadingState());
    final result = await authRepo.confirmPassword(
        confirmationRequest: ConfirmationRequest(
            email: email, password: password, passwordConfirmation: rePassword));
    result.fold(
          (failure) => emit(PasswordConfirmationFailureState(msg: failure.message)),
          (success) {
        CacheHelper.remove(key: SensitiveStrings.resetPasswordEmailKey);
        emit(PasswordConfirmationSuccessState());
      },
    );
  }

  @override
  Future<void> close() async {
    passwordController.dispose();
    rePasswordController.dispose();
    await super.close();
  }
}