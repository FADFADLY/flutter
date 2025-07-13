import 'package:graduationproject/core/constants/imports.dart';

import '../../domain/entity/update_comment_response_entity.dart';

class UpdateCommentResponseModel extends UpdateCommentResponseEntity {
  final bool success;
  final String message;
  final List<dynamic> data;
  final dynamic errors;
  final int code;

  UpdateCommentResponseModel({
    required this.success,
    required this.message,
    required this.data,
    this.errors,
    required this.code,
  }) : super(
            success: success,
            message: message,
            data: data,
            errors: errors,
            code: code);

  factory UpdateCommentResponseModel.fromJson(Map<String, dynamic> json) {
    return UpdateCommentResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? [],
      errors: json['errors'],
      code: json['code'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data,
      'errors': errors,
      'code': code,
    };
  }
}
