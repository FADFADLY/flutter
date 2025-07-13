class SingleArticle {
  final int id;
  final String title;
  final String author;
  final String image;
  final String createdAt;
  final int views;
  final int likes;
  final int share;
  final String body;
  final bool reacted;

  const SingleArticle({
    required this.reacted,
    required this.id,
    required this.title,
    required this.author,
    required this.image,
    required this.createdAt,
    required this.views,
    required this.likes,
    required this.share,
    required this.body,
  });
}
