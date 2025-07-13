import 'package:graduationproject/features/profile/data/models/profile_model.dart';

import '../../domain/entity/profile_response_entity.dart';

class ProfileResponseModel extends ProfileResponseEntity {
  const ProfileResponseModel({
    required bool success,
    required String message,
    required ProfileModel data,
    required dynamic errors,
    required int code,
  }) : super(
          success: success,
          message: message,
          data: data,
          errors: errors,
          code: code,
        );

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: ProfileModel.fromJson(json['data'] ?? {}),
      errors: json['errors'],
      code: json['code'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': (data as ProfileModel).toJson(),
        'errors': errors,
        'code': code,
      };
}