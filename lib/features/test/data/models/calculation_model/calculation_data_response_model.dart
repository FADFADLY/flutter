import 'package:graduationproject/features/test/domain/entities/submit/calculation_data_entity.dart';

class CalculationDataResponseModel extends CalculationDataEntity {
  final int score;
  final String result;
  final String message;
  final String image;

  CalculationDataResponseModel( {required this.message,required this.image,required this.score, required this.result})
      : super(score: score ?? 0, result: result ?? '', message: message ?? '', image: image ?? '');

  factory CalculationDataResponseModel.fromJson(Map<String, dynamic> json) {
    return CalculationDataResponseModel(
      score: json['score'] as int,
      result: json['result'] as String,
      message: json['message'] as String,
      image: json['image'] as String,
    );
  }
}
