import '../../../domain/entity/single_article/single_article.dart';

class SingleArticleModel extends SingleArticle {
  const SingleArticleModel({
    required int id,
    required String title,
    required String author,
    required String image,
    required String createdAt,
    required int views,
    required int likes,
    required int share,
    required String body,
    required bool reacted,
  }) : super(
          reacted: reacted,
          id: id,
          title: title,
          author: author,
          image: image,
          createdAt: createdAt,
          views: views,
          likes: likes,
          share: share,
          body: body,
        );

  factory SingleArticleModel.fromJson(Map<String, dynamic> json) {
    return SingleArticleModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      image: json['image'] ?? '',
      createdAt: json['created_at'] ?? '',
      views: json['views'] ?? 0,
      likes: json['likes'] ?? 0,
      share: json['share'] ?? 0,
      body: json['body'] ?? '',
      reacted: json['reacted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "author": author,
        "image": image,
        "created_at": createdAt,
        "views": views,
        "likes": likes,
        "share": share,
        "body": body,
        "reacted": reacted
      };
}
