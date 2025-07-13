// features/auth/data/models/logout_response_model.dart

import '../../../domain/entities/logout_response_entity.dart';

class LogoutResponseModel extends LogoutResponseEntity {
  const LogoutResponseModel({
    required bool success,
    required String message,
    required List<dynamic> data,
    required dynamic errors,
    required int code,
  }) : super(
          success: success,
          message: message,
          data: data,
          errors: errors,
          code: code,
        );

  factory LogoutResponseModel.fromJson(Map<String, dynamic> json) {
    return LogoutResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
      errors: json['errors'],
      code: json['code'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data,
        'errors': errors,
        'code': code,
      };
}