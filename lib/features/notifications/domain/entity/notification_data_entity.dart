import 'package:graduationproject/features/notifications/domain/entity/sender_entity.dart';

class NotificationDataEntity {
  final String id;
  final String? targetId;
  final String type;
  final String message;
  final SenderEntity sender;
  final String createdAt;
  final bool isRead;

  NotificationDataEntity({
    required this.id,
    this.targetId,
    required this.type,
    required this.message,
    required this.sender,
    required this.createdAt,
    required this.isRead,
  });
}