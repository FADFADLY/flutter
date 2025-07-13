import '../../domain/entity/store_comment_response_entity.dart';

class StoreCommentResponseModel extends StoreCommentResponseEntity {
  const StoreCommentResponseModel({
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

  factory StoreCommentResponseModel.fromJson(Map<String, dynamic> json) {
    return StoreCommentResponseModel(
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