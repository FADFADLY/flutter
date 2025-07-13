import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/generated/l10n.dart';

import '../../../../../../core/constants/strings.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepo authRepository;

  SignupCubit({required this.authRepository}) : super(SignupInitialState());

  TextEditingController nameController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  final List<String> genders = ["male", "female"];
  String selectedGender = '';

  void updateGender(String? gender) {
    selectedGender = gender ?? '';
    emit(SignupGenderUpdatedState(selectedGender: selectedGender));
  }

  Future<void> registerUser({required BuildContext context}) async {
    autoValidateMode = AutovalidateMode.always;
    emit(SignupValidationState());

    if (!formKey.currentState!.validate()) {
      return;
    }

    formKey.currentState!.save();

    if (passwordController.text != confirmPasswordController.text) {
      emit(SignupFailureState(message: S.of(context).passwords_do_not_match));
      return;
    }

    emit(SignupLoadingState());
    String genderInEnglish = selectedGender == Strings.maleInArabic ?Strings.maleInEnglish : Strings.femaleInEnglish;
    final user = await authRepository.register(
      registerRequest: RegisterRequest(
        name: nameController.text,
        username: displayNameController.text,
        email: emailController.text,
        gender: genderInEnglish,
        age: ageController.text,
        password: passwordController.text,
        passwordConfirmation: confirmPasswordController.text,
      ),
    );
    user.fold(
          (failure) {
        emit(SignupFailureState(message: failure.message));
      },
          (success) {
        emit(SignupSuccessState());
      },
    );
  }

  @override
  Future<void> close() async {
    nameController.dispose();
    displayNameController.dispose();
    emailController.dispose();
    genderController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    ageController.dispose();
    await super.close();
  }
}