
import '../../domain/entity/vote_response_entity.dart';

class VoteResponseModel  extends VoteResponseEntity  {
  const VoteResponseModel({
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
  factory VoteResponseModel.fromJson(Map<String, dynamic> json) {
    return VoteResponseModel(
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