class UpdateNameResponseEntity {
  final bool success;
  final String message;
  final List<dynamic> data;
  final dynamic errors;
  final int code;

  UpdateNameResponseEntity({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
    required this.code,
  });
}