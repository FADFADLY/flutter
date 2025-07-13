
import '../../../domain/entities/question/answer.dart';

class AnswerModel extends AnswerEntity {
  AnswerModel({
    required int id,
    required String answer,
    required int questionId,
  }) : super(id: id, answer: answer, questionId: questionId);

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      id: json['id'] as int,
      answer: json['answer'] as String,
      questionId: json['question_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'answer': answer,
      'question_id': questionId,
    };
  }
}