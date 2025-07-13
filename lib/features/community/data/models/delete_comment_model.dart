import '../../domain/entity/delete_comment_entity.dart';

class DeleteCommentModel extends DeleteCommentEntity {
  const DeleteCommentModel({
    required bool success,
    required String message,
    required dynamic data,
    required int code,
  }) : super(
          success: success,
          message: message,
          data: data,
          code: code,
        );

  factory DeleteCommentModel.fromJson(Map<String, dynamic> json) {
    return DeleteCommentModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'],
      code: json['code'] as int,
    );
  }
}