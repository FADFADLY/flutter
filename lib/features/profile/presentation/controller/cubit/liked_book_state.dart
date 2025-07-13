part of 'liked_book_cubit.dart';

@immutable
sealed class BookLikedState {}

final class BookLikedInitial extends BookLikedState {}

final class BookLikedLoading extends BookLikedState {}

final class BookLikedLoaded extends BookLikedState {
  final List<BookDataEntity> books;

  BookLikedLoaded({required this.books});
}

final class BookLikedError extends BookLikedState {
  final String message;

  BookLikedError({required this.message});
}