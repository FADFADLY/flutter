import '../../domain/entity/mood_entry_entity.dart';

class MoodEntryModel extends MoodEntryEntity {
  const MoodEntryModel({
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

  factory MoodEntryModel.fromJson(Map<String, dynamic> json) {
    return MoodEntryModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'],
      errors: json['errors'],
      code: json['code'] as int,
    );
  }
}