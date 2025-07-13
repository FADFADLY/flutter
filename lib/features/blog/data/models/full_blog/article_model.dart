
import '../../../domain/entity/full_blog/article_entity.dart';

class ArticleModel extends ArticleEntity {
  const ArticleModel({
    required super.id,
    required super.title,
    required super.author,
    required super.image,
    required super.createdAt,
    required super.views,
    required super.likes,
    required super.share, required super.summary,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      image: json['image'],
      createdAt: json['created_at'],
      views: json['views'],
      likes: json['likes'],
      share: json['share'], summary:json['summary'],
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
      'summary': summary,
    };
  }
}
