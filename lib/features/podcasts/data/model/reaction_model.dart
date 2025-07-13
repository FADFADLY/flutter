import 'dart:convert';

import '../../domain/entity/reaction_entity.dart';
import '../../domain/entity/reaction_data_entity.dart';

class ReactionModel extends ReactionEntity {
  const ReactionModel({
    required super.success,
    required super.message,
    required super.data,
    required super.errors,
    required super.code,
  }) : super();

  factory ReactionModel.fromJson(Map<String, dynamic> json) {
    return ReactionModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?) ?? [],
      errors: json['errors'],
      code: json['code'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data,
        'errors': errors,
        'code': code,
      };
}