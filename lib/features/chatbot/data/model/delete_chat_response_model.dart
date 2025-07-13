import '../../domain/entity/delete_chat_response_entity.dart';

class DeleteChatResponseModel extends DeleteChatResponseEntity {
  const DeleteChatResponseModel({
    required bool success,
    required String message,
    required dynamic errors,
    required int code,
  }) : super(success: success, message: message, errors: errors, code: code);

  factory DeleteChatResponseModel.fromJson(Map<String, dynamic> json) {
    return DeleteChatResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      errors: json['errors'],
      code: json['code'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'errors': errors,
      'code': code,
    };
  }
}