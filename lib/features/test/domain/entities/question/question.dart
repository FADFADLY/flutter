import 'answer.dart';

class QuestionEntity {
  final int id;
  final String question;
  final List<AnswerEntity> answers;

  QuestionEntity({
    required this.id,
    required this.question,
    required this.answers,
  });
}