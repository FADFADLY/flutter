import '../../domain/entity/mood_tracker_response_entity.dart';

class MoodTrackerResponseModel extends MoodTrackerResponseEntity {
  final bool success;
  final String message;
  final List<dynamic> data; // قايمة ديناميكية لأنها فاضية دلوقتي
  final List<String>? errors; // ممكن تكون null لو مفيش أخطاء
  final int code;

  MoodTrackerResponseModel({
    required this.success,
    required this.message,
    required this.data,
    this.errors,
    required this.code,
  }) : super(message: message);

  // تحويل الـ JSON إلى Object
  factory MoodTrackerResponseModel.fromJson(Map<String, dynamic> json) {
    return MoodTrackerResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] as List<dynamic>,
      errors: json['errors'] != null ? List<String>.from(json['errors']) : null,
      code: json['code'] as int,
    );
  }

  // تحويل الكلاس إلى JSON (اختياري لو هتحتاجه)
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