abstract class DeleteChatResponseEntity {
  final bool success;
  final String message;
  final dynamic errors;
  final int code;

  const DeleteChatResponseEntity({
    required this.success,
    required this.message,
    required this.errors,
    required this.code,
  });
}