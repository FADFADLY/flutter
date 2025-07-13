import 'package:graduationproject/features/test/data/models/question_response_model/question_test_modal.dart';


class QuestionTestResponseModel {
  final bool success;
  final String message;
  final QuestionsTestModel? data;
  final dynamic errors;
  final int code;

  QuestionTestResponseModel({
    required this.success,
    required this.message,
    this.data,
    this.errors,
    required this.code,
  });

  factory QuestionTestResponseModel.fromJson(Map<String, dynamic> json) {
    return QuestionTestResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] != null ? QuestionsTestModel.fromJson(json['data'] as Map<String, dynamic>) : null,
      errors: json['errors'],
      code: json['code'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
      'errors': errors,
      'code': code,
    };
  }
}