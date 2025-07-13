import 'dart:convert';

import '../../domain/entity/comment_entity.dart';
import 'comment_user_model.dart';

class CommentModel extends CommentEntity {
  const CommentModel({
    required super.id,
    required super.body,
    required super.postId,
    required super.createdAt,
    required super.reactionsCount,
    required super.reacted,
    required super.user,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] as int,
      body: json['body'] as String,
      postId: json['post_id'].toString(), // Convert to String
      createdAt: json['created_at'] as String,
      reactionsCount: json['reactions_count'] as int,
      reacted: json['reacted'] as bool,
      user: CommentUserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'body': body,
      'post_id': postId,
      'created_at': createdAt,
      'reactions_count': reactionsCount,
      'reacted': reacted,
      'user': (user as CommentUserModel).toJson(),
    };
  }
}
