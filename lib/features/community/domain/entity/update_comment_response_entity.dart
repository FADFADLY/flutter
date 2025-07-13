class UpdateCommentResponseEntity {
  final bool success;
  final String message;
  final List<dynamic> data;
  final dynamic errors;
  final int code;

  UpdateCommentResponseEntity({
    required this.success,
    required this.message,
    required this.data,
    this.errors,
    required this.code,
  });
}