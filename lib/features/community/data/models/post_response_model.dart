// lib/features/social_media/data/models/post_response_model.dart

import 'package:graduationproject/features/community/data/models/post_data_model.dart';

import '../../domain/entity/posts_response_entity.dart';

class PostResponseModel extends PostResponseEntity {
  const PostResponseModel({
    required bool success,
    required String message,
    required List<PostDataModel> data,
    required dynamic errors,
    required int code,
  }) : super(
    success: success,
    message: message,
    data: data,
    errors: errors,
    code: code,
  );

  factory PostResponseModel.fromJson(Map<String, dynamic> json) {
    return PostResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => PostDataModel.fromJson(item as Map<String, dynamic>))
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
      'data': data.map((item) => (item as PostDataModel).toJson()).toList(),
      'errors': errors,
      'code': code,
    };
  }
}