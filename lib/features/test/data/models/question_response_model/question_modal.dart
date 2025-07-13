
import '../../../domain/entities/question/question.dart';
import 'answer_modal.dart';



class QuestionModel extends QuestionEntity {
  QuestionModel({
    required int id,
    required String question,
    required List<AnswerModel> answers,
  }) : super(id: id, question: question, answers: answers);

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] as int,
      question: json['question'] as String,
      answers: (json['answers'] as List<dynamic>)
          .map((answerJson) => AnswerModel.fromJson(answerJson as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answers': answers.map((answer) => (answer as AnswerModel).toJson()).toList(),
    };
  }
}