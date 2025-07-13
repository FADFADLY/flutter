import '../../domain/entity/update_avatar_entity.dart';
class UpdateAvatarResponseModel extends UpdateAvatarResponseEntity {
  UpdateAvatarResponseModel({
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
  factory UpdateAvatarResponseModel.fromJson(Map<String, dynamic> json) {
    return UpdateAvatarResponseModel(
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