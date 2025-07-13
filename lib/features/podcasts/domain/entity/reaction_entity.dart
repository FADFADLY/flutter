import '../../domain/entity/reaction_data_entity.dart';

class ReactionEntity {
  final bool success;
  final String message;
  final List<dynamic> data;
  final dynamic errors;
  final int code;

  const ReactionEntity({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
    required this.code,
  });
}