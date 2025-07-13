import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:graduationproject/core/constants/imports.dart';
import '../../../../../../config/cache/secure_cache_helper.dart';
import '../../../../../../core/constants/sensitive_strings.dart';

part 'signin_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this.authRepository) : super(SignInInitialState());
  final AuthRepo authRepository;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login({required BuildContext context}) async {
    autoValidateMode = AutovalidateMode.always;
    emit(SignInValidationState());

    if (!formKey.currentState!.validate()) {
      return;
    }

    formKey.currentState!.save();

    emit(SignInLoadingState());
    final user = await authRepository.login(
        loginRequest: LoginRequest(
            email: emailController.text, password: passwordController.text));
    user.fold(
          (failure) => emit(SignInFailureState(message: failure.message)),
          (user) async {
        await SecureCacheHelper.set(key: SensitiveStrings.accessToken, value: user.token);
        emit(SignInSuccessState(loginUserEntity: user));
      },
    );
  }

  @override
  Future<void> close() async {
    emailController.dispose();
    passwordController.dispose();
    await super.close();
  }
}