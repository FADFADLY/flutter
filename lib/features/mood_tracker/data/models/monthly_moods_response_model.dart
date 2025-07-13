import '../../domain/entity/monthly_moods_response_entity.dart';
import 'monthly_mood_entry_model.dart';

class MonthlyMoodsResponseModel extends MonthlyMoodsResponseEntity {
  const MonthlyMoodsResponseModel({
    required bool success,
    required String message,
    required List<MonthlyMoodEntryModel> data,
    required int code,
  }) : super(
          success: success,
          message: message,
          data: data,
          code: code,
        );

  factory MonthlyMoodsResponseModel.fromJson(Map<String, dynamic> json) {
    return MonthlyMoodsResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => MonthlyMoodEntryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      code: json['code'] as int,
    );
  }
}