import 'dart:convert';

import '../../domain/entity/get_comments_entity.dart';
import 'comment_model.dart';

class GetCommentsModel extends GetCommentsEntity {
  const GetCommentsModel({
    required super.success,
    required super.message,
    required super.data,
    required super.errors,
    required super.code,
  });

  factory GetCommentsModel.fromJson(Map<String, dynamic> json) {
    return GetCommentsModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => CommentModel.fromJson(item as Map<String, dynamic>))
          .toList() ??
          [],
      errors: json['errors'],
      code: json['code'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((item) => (item as CommentModel).toJson()).toList(),
      'errors': errors,
      'code': code,
    };
  }
}