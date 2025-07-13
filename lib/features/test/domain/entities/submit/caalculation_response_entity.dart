import 'package:graduationproject/features/test/domain/entities/submit/calculation_data_entity.dart';

class CalculationResponseEntity {
  final bool success;
  final String message;
  final CalculationDataEntity? data;
  final int code;

  CalculationResponseEntity({
    required this.success,
    required this.message,
    required this.data,
    required this.code,
  });
}