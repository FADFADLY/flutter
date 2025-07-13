part of 'pin_code_cubit.dart';

@immutable
abstract class PinCodeState {}

class VerificationInitial extends PinCodeState {}

class VerificationLoadingState extends PinCodeState {}

class VerificationSuccessState extends PinCodeState {}

class VerificationFailureState extends PinCodeState {
  final String message;
  VerificationFailureState({required this.message});
}

class VerificationValidationState extends PinCodeState {}