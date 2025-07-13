part of 'password_confirmation_cubit.dart';

@immutable
sealed class PasswordConfirmationState {}

final class PasswordConfirmationInitial extends PasswordConfirmationState {}
final class PasswordConfirmationLoadingState extends PasswordConfirmationState {}
final class PasswordConfirmationFailureState extends PasswordConfirmationState {
 final String msg;
 PasswordConfirmationFailureState({required this.msg});
}
final class PasswordConfirmationSuccessState extends PasswordConfirmationState {}
final class PasswordConfirmationValidationState extends PasswordConfirmationState {}