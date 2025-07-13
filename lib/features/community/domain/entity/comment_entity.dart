import 'comment_user_entity.dart';

class CommentEntity {
  final int id;
  final String body;
  final String postId;
  final String createdAt;
  final int reactionsCount;
  final bool reacted;
  final CommentUserEntity user;

  const CommentEntity({
    required this.id,
    required this.body,
    required this.postId,
    required this.createdAt,
    required this.reactionsCount,
    required this.reacted,
    required this.user,
  });
}

