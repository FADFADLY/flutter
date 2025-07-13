import '../../../domain/entity/full_blog/blog_response_entity.dart';
import 'article_model.dart';

class BlogResponseModel extends BlogResponseEntity {
  const BlogResponseModel({
    required super.success,
    required super.message,
    required List<ArticleModel> data,
    required super.errors,
    required super.code,
  }) : super(data: data);

  factory BlogResponseModel.fromJson(Map<String, dynamic> json) {
    return BlogResponseModel(
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List)
          .map((item) => ArticleModel.fromJson(item))
          .toList(),
      errors: json['errors'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((e) => (e as ArticleModel).toJson()).toList(),
      'errors': errors,
      'code': code,
    };
  }
}
