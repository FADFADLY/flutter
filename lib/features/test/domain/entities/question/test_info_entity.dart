import 'package:graduationproject/features/test/domain/entities/question/question.dart';

class TestInfoEntity {
  final String name;
  final String description;
  final List<QuestionEntity> questions;

  TestInfoEntity({
    required this.name,
    required this.description,
    required this.questions,
  });
}