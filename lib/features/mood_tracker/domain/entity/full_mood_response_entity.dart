
import 'data_mood_entity.dart';

class FullModeEntity {
  final bool success;
  final String message;
  final List<DataMoodEntity> data;
  final dynamic errors;
  final int code;

  const FullModeEntity({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
    required this.code,
  });
}