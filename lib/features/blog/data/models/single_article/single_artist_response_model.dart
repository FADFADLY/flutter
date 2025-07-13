import '../../../domain/entity/single_article/single_article_response.dart';
import 'single_article_model.dart';

class SingleArticleResponseModel extends SingleArticleResponse {
  const SingleArticleResponseModel({
    required bool success,
    required String message,
    required SingleArticleModel? data,
    required int code,
  }) : super(
    success: success,
    message: message,
    data: data,
    code: code,
  );

  factory SingleArticleResponseModel.fromJson(Map<String, dynamic> json) {
    return SingleArticleResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? SingleArticleModel.fromJson(json['data']) : null,
      code: json['code'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data is SingleArticleModel ? (data as SingleArticleModel).toJson() : null,
    "code": code,
  };
}
