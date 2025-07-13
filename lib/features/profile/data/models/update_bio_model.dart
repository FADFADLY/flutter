
import '../../domain/entity/update_bio_entity.dart';
import '../../domain/entity/update_name_entity.dart';

class UpdateBioResponseModel extends UpdateBioResponseEntity {
  UpdateBioResponseModel({
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

  factory UpdateBioResponseModel.fromJson(Map<String, dynamic> json) {
    return UpdateBioResponseModel(
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
