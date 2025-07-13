class UpdateAvatarResponseEntity {
  final bool success;
  final String message;
  final List<dynamic> data;
  final dynamic errors;
  final int code;

  UpdateAvatarResponseEntity({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
    required this.code,
  });
}