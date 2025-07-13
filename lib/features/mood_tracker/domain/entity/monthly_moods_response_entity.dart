import 'monthly_mood_entry_entity.dart';

class MonthlyMoodsResponseEntity {
  final bool success;
  final String message;
  final List<MonthlyMoodEntryEntity> data;
  final int code;

  const MonthlyMoodsResponseEntity({
    required this.success,
    required this.message,
    required this.data,
    required this.code,
  });
}