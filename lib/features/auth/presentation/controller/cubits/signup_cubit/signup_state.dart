part of 'signup_cubit.dart';

abstract class SignupState {}

final class SignupInitialState extends SignupState {}

final class SignupLoadingState extends SignupState {}

final class SignupSuccessState extends SignupState {}

final class SignupFailureState extends SignupState {
  final String message;
  SignupFailureState({required this.message});
}

final class SignupGenderUpdatedState extends SignupState {
  final String selectedGender;
  SignupGenderUpdatedState({required this.selectedGender});
}

final class SignupValidationState extends SignupState {}