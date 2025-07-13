import '../../domain/entity/book_response_entity.dart';
import 'book_data_model.dart';

class BookResponseModel extends BookResponseEntity {
  const BookResponseModel({
    required bool success,
    required String message,
    required List<BookModel> data,
    required dynamic errors,
    required int code,
  }) : super(
          success: success,
          message: message,
          data: data,
          errors: errors,
          code: code,
        );

  factory BookResponseModel.fromJson(Map<String, dynamic> json) {
    return BookResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => BookModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      errors: json['errors'],
      code: json['code'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data.map((book) => (book as BookModel).toJson()).toList(),
        'errors': errors,
        'code': code,
      };
}