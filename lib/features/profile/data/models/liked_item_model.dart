import 'package:graduationproject/features/profile/domain/entity/liked_item_entity.dart';

class LikedItemModel extends LikedItemEntity {
  LikedItemModel({
    required int id,
    required String title,
    required String author,
    required String image,
    required String createdAt,
    required int views,
    required int likes,
    required int share,
    required bool reacted,
  }) : super(
          id: id,
          title: title,
          author: author,
          image: image,
          createdAt: createdAt,
          views: views,
          likes: likes,
          share: share,
          reacted: reacted,
        );

  factory LikedItemModel.fromJson(Map<String, dynamic> json) {
    return LikedItemModel(
      id: json['id'] as int,
      title: json['title'] as String,
      author: json['author'] as String,
      image: json['image'] as String,
      createdAt: json['created_at'] as String,
      views: json['views'] as int,
      likes: json['likes'] as int,
      share: json['share'] as int,
      reacted: json['reacted'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'image': image,
      'created_at': createdAt,
      'views': views,
      'likes': likes,
      'share': share,
      'reacted': reacted,
    };
  }
}