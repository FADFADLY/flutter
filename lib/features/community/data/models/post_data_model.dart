import '../../domain/entity/posts_data_entity.dart';
import 'attachment_model.dart';

class PostDataModel extends PostDataEntity {
  const PostDataModel({
    required int id,
    required String content,
    required String type,
    required dynamic attachment,
    required String createdAt,
    required String userName,
    required int commentsCount,
    required int reactionsCount,
    required bool reacted,
  }) : super(
    id: id,
    content: content,
    type: type,
    attachment: attachment,
    createdAt: createdAt,
    userName: userName,
    commentsCount: commentsCount,
    reactionsCount: reactionsCount,
    reacted: reacted,
  );

  factory PostDataModel.fromJson(Map<String, dynamic> json) {
    final attachmentJson = json['attachment'];
    dynamic attachment;

    if (attachmentJson is List<dynamic> && attachmentJson.isNotEmpty) {
      // Handle list of attachments (e.g., poll options)
      attachment = attachmentJson
          .map((item) => AttachmentModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } else if (attachmentJson is Map<String, dynamic>) {
      // Handle single attachment (e.g., location, article)
      attachment = AttachmentModel.fromJson(attachmentJson);
    } else {
      // Handle string attachments (e.g., image, file, audio) or null
      attachment = attachmentJson;
    }

    return PostDataModel(
      id: json['id'] ?? 0,
      content: json['content'] ?? '',
      type: json['type'] ?? '',
      attachment: attachment,
      createdAt: json['created_at'] ?? '',
      userName: json['user_name'] ?? '',
      commentsCount: json['comments_count'] ?? 0,
      reactionsCount: json['reactions_count'] ?? 0,
      reacted: json['reacted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    dynamic attachmentJson;
    if (attachment is List<AttachmentModel>) {
      attachmentJson = (attachment as List<AttachmentModel>)
          .map((item) => item.toJson())
          .toList();
    } else if (attachment is AttachmentModel) {
      attachmentJson = (attachment as AttachmentModel).toJson();
    } else {
      attachmentJson = attachment;
    }

    return {
      'id': id,
      'content': content,
      'type': type,
      'attachment': attachmentJson,
      'created_at': createdAt,
      'user_name': userName,
      'comments_count': commentsCount,
      'reactions_count': reactionsCount,
      'reacted': reacted,
    };
  }
}