import 'notification_data_entity.dart';

class NotificationEntity {
  final bool success;
  final String message;
  final List<NotificationDataEntity> data;
  final dynamic errors;
  final int code;

  NotificationEntity({
    required this.success,
    required this.message,
    required this.data,
    this.errors,
    required this.code,
  });
}