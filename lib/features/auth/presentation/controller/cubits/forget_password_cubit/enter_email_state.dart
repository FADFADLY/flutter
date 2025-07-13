part of 'enter_email_cubit.dart';

@immutable
sealed class EnterEmailState {}

final class ForgetPasswordInitial extends EnterEmailState {}

final class ForgetPasswordLoadingState extends EnterEmailState {}

final class ForgetPasswordSuccessState extends EnterEmailState {}

final class ForgetPasswordFailureState extends EnterEmailState {
  final String message;
  ForgetPasswordFailureState({required this.message});
}

final class ForgetPasswordValidationState extends EnterEmailState {}