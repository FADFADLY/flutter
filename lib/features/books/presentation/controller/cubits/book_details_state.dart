part of 'book_details_cubit.dart';

@immutable
sealed class BookDetailsState {}

final class BookDetailsInitial extends BookDetailsState {}

final class BookDetailsLoading extends BookDetailsState {}

final class BookDetailsLoaded extends BookDetailsState {
  final BookDetailsDataEntity details;

  BookDetailsLoaded({required this.details});
}

final class BookDetailsError extends BookDetailsState {
  final String message;

  BookDetailsError({required this.message});
}