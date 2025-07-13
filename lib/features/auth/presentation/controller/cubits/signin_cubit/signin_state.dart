part of 'signin_cubit.dart';

@immutable
abstract class SignInState {}

class SignInInitialState extends SignInState {}

class SignInLoadingState extends SignInState {}

class SignInSuccessState extends SignInState {
  final LoginUserEntity loginUserEntity;
  SignInSuccessState({required this.loginUserEntity});
}

class SignInFailureState extends SignInState {
  final String message;
  SignInFailureState({required this.message});
}

class SignInValidationState extends SignInState {}