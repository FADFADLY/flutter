import '../../../podcasts/domain/entity/reaction_entity.dart';
import '../../domain/entity/reaction_entity.dart';

class PostReactionModel extends PostReactionEntity {
  const PostReactionModel({
    required bool success,
    required String message,
    required dynamic data,
    required dynamic errors,
    required int code,
  }) : super(
    message: message,
    success: success,
    data: data,
    errors: errors,
    code: code,

  );

  factory PostReactionModel.fromJson(Map<String, dynamic> json) {
    return PostReactionModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'],
      errors: json['errors'],
      code: json['code'] ?? 0,
    );
  }


}