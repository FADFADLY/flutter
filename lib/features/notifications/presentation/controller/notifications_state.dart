part of 'notifications_cubit.dart';

abstract class NotificationsState {
  const NotificationsState();
}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final NotificationEntity response;

  const NotificationsLoaded({required this.response});
}

class NotificationsError extends NotificationsState {
  final String message;

  const NotificationsError({required this.message});
}