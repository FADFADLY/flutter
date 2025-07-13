part of 'logout_cubit.dart';

@immutable
sealed class LogoutState {}

final class LogoutInitial extends LogoutState {}

final class LogoutLoading extends LogoutState {}

final class LogoutNavigationDone extends LogoutState {}

final class LogoutSuccess extends LogoutState {
  final LogoutResponseEntity logoutResponse;

  LogoutSuccess({required this.logoutResponse});
}

final class LogoutError extends LogoutState {
  final String message;

  LogoutError({required this.message});
}