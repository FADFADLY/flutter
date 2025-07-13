// lib/features/social_media/domain/entities/post_response_entity.dart

import 'package:graduationproject/features/community/domain/entity/posts_data_entity.dart';

import 'comment_entity.dart';
import 'comment_user_entity.dart';

 class GetCommentsEntity {
  final bool success;
  final String message;
  final List<CommentEntity> data;
  final dynamic errors;
  final int code;

  const GetCommentsEntity({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
    required this.code,
  });
}