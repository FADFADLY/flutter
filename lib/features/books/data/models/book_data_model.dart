import '../../domain/entity/book_data_entity.dart';

class BookModel extends BookDataEntity {
  const BookModel({
    required int id,
    required String title,
    required String cover,
  }) : super(
          id: id,
          title: title,
          cover: cover,
        );

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      cover: json['cover'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'cover': cover,
      };
}