import 'score_data_entity.dart';

class StoreHabitsResponseEntity {
  final bool success;
  final String message;
  final ScoreDataEntity data;
  final dynamic errors;
  final int code;

  const StoreHabitsResponseEntity({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
    required this.code,
  });
}
