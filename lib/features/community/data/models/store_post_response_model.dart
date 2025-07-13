
import '../../domain/entity/store_post_response_entity.dart';

class StorePostResponseModel  extends StorePostEntity  {
  const StorePostResponseModel({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
    required this.code,
  }) : super(message: message);

  final bool success;
  final String message;
  final dynamic data;
  final dynamic errors;
  final int code;
  factory StorePostResponseModel.fromJson(Map<String, dynamic> json) {
    return StorePostResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? {},
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