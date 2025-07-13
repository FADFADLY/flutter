import '../../domain/entity/notification_data_entity.dart';
import 'sender_model.dart';

class NotificationDataModel extends NotificationDataEntity {
  NotificationDataModel({
    required String id,
    String? targetId,
    required String type,
    required String message,
    required SenderModel sender,
    required String createdAt,
    required bool isRead,
  }) : super(
          id: id,
          targetId: targetId,
          type: type,
          message: message,
          sender: sender,
          createdAt: createdAt,
          isRead: isRead,
        );

  factory NotificationDataModel.fromJson(Map<String, dynamic> json) {
    return NotificationDataModel(
      id: json['id'] as String,
      targetId: json['target_id']?.toString(),
      type: json['type'] as String,
      message: json['message'] as String,
      sender: SenderModel.fromJson(json['sender'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String,
      isRead: json['is_read'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'target_id': targetId,
      'type': type,
      'message': message,
      'sender': (sender as SenderModel).toJson(),
      'created_at': createdAt,
      'is_read': isRead,
    };
  }
}