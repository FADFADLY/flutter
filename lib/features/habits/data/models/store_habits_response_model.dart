import '../../domain/entity/store_habits_response_entity.dart';
import 'score_data_model.dart';

class StoreHabitsResponseModel extends StoreHabitsResponseEntity {
  const StoreHabitsResponseModel({
    required bool success,
    required String message,
    required ScoreDataModel data,
    required dynamic errors,
    required int code,
  }) : super(
    success: success,
    message: message,
    data: data,
    errors: errors,
    code: code,
  );

  factory StoreHabitsResponseModel.fromJson(Map<String, dynamic> json) {
    return StoreHabitsResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: ScoreDataModel.fromJson(json['data'] ?? {}),
      errors: json['errors'],
      code: json['code'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': (data as ScoreDataModel).toJson(),
    'errors': errors,
    'code': code,
  };
}
