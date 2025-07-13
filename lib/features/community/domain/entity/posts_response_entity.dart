// lib/features/social_media/domain/entities/post_response_entity.dart

import 'package:graduationproject/features/community/domain/entity/posts_data_entity.dart';

abstract class PostResponseEntity {
  final bool success;
  final String message;
  final List<PostDataEntity> data;
  final dynamic errors;
  final int code;

  const PostResponseEntity({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
    required this.code,
  });
}