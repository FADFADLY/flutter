import 'dart:convert';

import '../../../domain/entity/blog_reaction/blog_reaction_response_entity.dart';

class BlogReactionResponseModel extends BlogReactionResponseEntity {
  BlogReactionResponseModel({
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

  factory BlogReactionResponseModel.fromJson(Map<String, dynamic> json) {
    return BlogReactionResponseModel(
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