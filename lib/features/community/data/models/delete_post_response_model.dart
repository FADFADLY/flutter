import 'dart:convert';
import '../../domain/entity/delete_post_entity.dart';

class DeletePostModel extends DeletePostEntity {
  const DeletePostModel({
    required super.success,
    required super.message,
    required super.data,
    required super.code,
  });

  factory DeletePostModel.fromJson(Map<String, dynamic> json) {
    return DeletePostModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'],
      code: json['code'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data,
      'code': code,
    };
  }
}