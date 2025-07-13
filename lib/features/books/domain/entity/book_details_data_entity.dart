class BookDetailsDataEntity {
  final int id;
  final String title;
  final String cover;
  final String author;
  final String genre;
  final String publisher;
  final String publicationDate;
  final String pagesCount;
  final String description;
  final bool reacted;

  const BookDetailsDataEntity({
    required this.id,
    required this.title,
    required this.cover,
    required this.author,
    required this.genre,
    required this.publisher,
    required this.publicationDate,
    required this.pagesCount,
    required this.description,
    required this.reacted,
  });
}