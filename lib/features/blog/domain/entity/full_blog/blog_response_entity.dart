
import 'article_entity.dart';

class BlogResponseEntity {
  final bool success;
  final String message;
  final List<ArticleEntity> data;
  final dynamic errors;
  final int code;

  const BlogResponseEntity({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
    required this.code,
  });
}
