

import '../../domain/entity/habit_response_entity.dart';
import 'habit_data_model.dart';

class HabitResponseModel extends HabitResponseEntity {
  const HabitResponseModel({
    required bool success,
    required String message,
    required List<HabitModel> data,
    required dynamic errors,
    required int code,
  }) :
        super(
          success: success,
          message: message,
          data: data,
          errors: errors,
          code: code,
        );

  factory HabitResponseModel.fromJson(Map<String, dynamic> json) {
    return HabitResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] is Map
          ? (json['data']['habits'] as List<dynamic>?)
          ?.map((item) => HabitModel.fromJson(item as Map<String, dynamic>))
          .toList()
          : (json['data'] as List<dynamic>?)
          ?.map((item) => HabitModel.fromJson(item as Map<String, dynamic>))
          .toList()) ?? [],
      errors: json['errors'],
      code: json['code'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data.map((habit) => (habit as HabitModel).toJson()).toList(),
        'errors': errors,
        'code': code,
      };
}