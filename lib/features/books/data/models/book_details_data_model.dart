import '../../domain/entity/book_details_data_entity.dart';

class BookDetailsDataModel extends BookDetailsDataEntity {
  const BookDetailsDataModel({
    required int id,
    required String title,
    required String cover,
    required String author,
    required String genre,
    required String publisher,
    required String publicationDate,
    required String pagesCount,
    required String description,
    required bool reacted,
  }) : super(
          id: id,
          title: title,
          cover: cover,
          author: author,
          genre: genre,
          publisher: publisher,
          publicationDate: publicationDate,
          pagesCount: pagesCount,
          description: description,
          reacted: reacted,
        );

  factory BookDetailsDataModel.fromJson(Map<String, dynamic> json) {
    return BookDetailsDataModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      cover: json['cover'] ?? '',
      author: json['author'] ?? '',
      genre: json['genre'] ?? '',
      publisher: json['publisher'] ?? '',
      publicationDate: json['publication_date'] ?? '',
      pagesCount: json['pages_count'] ?? '',
      description: json['description'] ?? '',
      reacted: json['reacted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'cover': cover,
        'author': author,
        'genre': genre,
        'publisher': publisher,
        'publication_date': publicationDate,
        'pages_count': pagesCount,
        'description': description,
      };
}