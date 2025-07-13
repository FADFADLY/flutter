import '../../../domain/entities/submit/caalculation_response_entity.dart';
import 'calculation_data_response_model.dart';

class CalculationResponseModel extends CalculationResponseEntity {
  CalculationResponseModel({
    required bool success,
    required String message,
    required CalculationDataResponseModel? data,
    required int code,
  }) : super(
    success: success,
    message: message,
    data: data,
    code: code,
  );

  factory CalculationResponseModel.fromJson(Map<String, dynamic> json) {
    return CalculationResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] != null
          ? CalculationDataResponseModel.fromJson(json['data'] as Map<String, dynamic>)
          : null,
      code: json['code'] as int,
    );
  }

}