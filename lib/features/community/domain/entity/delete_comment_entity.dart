class DeleteCommentEntity {
  final bool success;
  final String message;
  final dynamic data;
  final int code;

  const DeleteCommentEntity({
    required this.success,
    required this.message,
    required this.data,
    required this.code,
  });
}