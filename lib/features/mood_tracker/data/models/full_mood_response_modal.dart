
import '../../domain/entity/full_mood_response_entity.dart';
import 'data_mood_model.dart';

class FullMoodResponseModal extends FullModeEntity {
  FullMoodResponseModal({
    required bool success,
    required String message,
    required List<DataMoodModel> data,
    required dynamic errors,
    required int code,
  }) : super(
    success: success,
    message: message,
    data: data,
    errors: errors,
    code: code,
  );

  // تحويل من JSON إلى MoodResponseModel
  factory FullMoodResponseModal.fromJson(Map<String, dynamic> json) {
    return FullMoodResponseModal(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((item) => DataMoodModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      errors: json['errors'],
      code: json['code'] as int,
    );
  }
}
