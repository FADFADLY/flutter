import 'package:graduationproject/features/test/data/models/question_response_model/question_modal.dart';

import '../../../domain/entities/question/test_info_entity.dart';


class QuestionsTestModel extends TestInfoEntity{
  final int id;
  final String name;
  final String description;
  final List<QuestionModel> questions;

  QuestionsTestModel({
    required this.id,
    required this.name,
    required this.description,
    required this.questions,
  }) : super(name: name, description: description , questions: questions);

  factory QuestionsTestModel.fromJson(Map<String, dynamic> json) {
    return QuestionsTestModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map((questionJson) => QuestionModel.fromJson(questionJson as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'questions': questions.map((question) => question.toJson()).toList(),
    };
  }
}