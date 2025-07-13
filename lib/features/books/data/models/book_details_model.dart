import 'package:graduationproject/features/books/data/models/book_data_model.dart';
import '../../domain/entity/book_details_entity.dart';
import 'book_details_data_model.dart';

class BookDetailsModel extends BookDetailsEntity {
  const BookDetailsModel({
    required bool success,
    required String message,
    required BookDetailsDataModel data,
    required dynamic errors,
    required int code,
  }) : super(
          success: success,
          message: message,
          data: data,
          errors: errors,
          code: code,
        );

  factory BookDetailsModel.fromJson(Map<String, dynamic> json) {
    return BookDetailsModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: BookDetailsDataModel.fromJson(json['data'] as Map<String, dynamic>),
      errors: json['errors'],
      code: json['code'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': (data as BookDetailsDataModel).toJson(),
        'errors': errors,
        'code': code,
      };
}

