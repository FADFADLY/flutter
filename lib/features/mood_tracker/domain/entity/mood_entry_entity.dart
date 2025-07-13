class MoodEntryEntity {
  final bool success;
  final String message;
  final dynamic data;
  final dynamic errors;
  final int code;

  const MoodEntryEntity({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
    required this.code,
  });
}