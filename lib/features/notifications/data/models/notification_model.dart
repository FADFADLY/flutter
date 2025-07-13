import '../../domain/entity/notification_entity.dart';
import 'notification_data_model.dart';

class NotificationModel extends NotificationEntity {
  NotificationModel({
    required bool success,
    required String message,
    required List<NotificationDataModel> data,
    dynamic errors,
    required int code,
  }) : super(
          success: success,
          message: message,
          data: data,
          errors: errors,
          code: code,
        );

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((item) => NotificationDataModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      errors: json['errors'],
      code: json['code'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((item) => (item as NotificationDataModel).toJson()).toList(),
      'errors': errors,
      'code': code,
    };
  }
}