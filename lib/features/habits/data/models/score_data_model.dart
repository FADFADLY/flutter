import '../../domain/entity/score_data_entity.dart';

class ScoreDataModel extends ScoreDataEntity {
  const ScoreDataModel({
    required int score,
    required int fullMark,
  }) : super(
    score: score,
    fullMark: fullMark,
  );

  factory ScoreDataModel.fromJson(Map<String, dynamic> json) {
    return ScoreDataModel(
      score: json['score'] ?? 0,
      fullMark: json['full_mark'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'score': score,
    'full_mark': fullMark,
  };
}
