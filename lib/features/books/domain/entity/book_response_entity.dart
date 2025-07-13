import 'book_data_entity.dart';

class BookResponseEntity {
  final bool success;
  final String message;
  final List<BookDataEntity> data;
  final dynamic errors;
  final int code;

  const BookResponseEntity({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
    required this.code,
  });
}