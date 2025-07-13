import '../../domain/entity/update_post_entity.dart';

class UpdatePostModel extends UpdatePostEntity {
  const UpdatePostModel({
    required bool success,
    required String message,
    required dynamic data,
    required dynamic errors,
    required int code,
  }) : super(
          success: success,
          message: message,
          data: data,
          errors: errors,
          code: code,
        );

  factory UpdatePostModel.fromJson(Map<String, dynamic> json) {
    return UpdatePostModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'],
      errors: json['errors'],
      code: json['code'] as int,
    );
  }
}