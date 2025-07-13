import 'package:graduationproject/features/blog/domain/entity/single_article/single_article.dart';

class SingleArticleResponse {
  final bool success;
  final String message;
  final SingleArticle? data;
  final int code;

  const SingleArticleResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.code,
  });
}
