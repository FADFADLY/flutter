// lib/features/social_media/domain/entities/post_data_entity.dart

import 'attachment_entity.dart';

 class PostDataEntity {
  final int id;
  final String content;
  final String type;
  final dynamic attachment; // Can be List<AttachmentEntity>, AttachmentEntity, String, or null
  final String createdAt;
  final String userName;
  final int commentsCount;
  final int reactionsCount;
  final bool reacted;

  const PostDataEntity({
    required this.id,
    required this.content,
    required this.type,
    required this.attachment,
    required this.createdAt,
    required this.userName,
    required this.commentsCount,
    required this.reactionsCount,
    required this.reacted,
  });
}