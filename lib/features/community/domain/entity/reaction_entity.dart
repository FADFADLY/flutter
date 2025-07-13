class PostReactionEntity {
  final bool success;
  final String message;
  final List<dynamic> data;
  final dynamic errors;
  final int code;

  const PostReactionEntity({
    required this.message,
    required this.success,
    required this.data,
    required this.errors,
    required this.code,
  });
}
