import '../../domain/entity/comment_user_entity.dart';

class CommentUserModel extends CommentUserEntity {
  const CommentUserModel({
    required super.username,
    required super.image,
  });

  factory CommentUserModel.fromJson(Map<String, dynamic> json) {
    return CommentUserModel(
      username: json['user'] ?? '', // Handle null username
      image: json['image'] ?? '',    // Handle null image
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': username,
      'image': image,
    };
  }
}