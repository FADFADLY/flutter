
import 'book_details_data_entity.dart';

class BookDetailsEntity {
  final bool success;
  final String message;
  final BookDetailsDataEntity data;
  final dynamic errors;
  final int code;

  const BookDetailsEntity({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
    required this.code,
  });
}

