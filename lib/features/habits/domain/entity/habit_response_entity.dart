import 'habit_data_entity.dart';

class HabitResponseEntity {
  final bool success;
  final String message;
  final List<HabitDataEntity> data;
  final dynamic errors;
  final int code;

  const HabitResponseEntity({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
    required this.code,
  });
}