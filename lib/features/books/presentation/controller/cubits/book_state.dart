part of 'book_cubit.dart';

@immutable
sealed class BookState {}

final class BookInitial extends BookState {}

final class BookLoading extends BookState {}

final class BookLoaded extends BookState {
  final List<BookDataEntity> books;

  BookLoaded({required this.books});
}

final class BookError extends BookState {
  final String message;

  BookError({required this.message});
}