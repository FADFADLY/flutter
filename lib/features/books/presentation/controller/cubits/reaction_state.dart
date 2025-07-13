part of 'reaction_cubit.dart';

@immutable
sealed class BooksReactionState {}

final class BooksReactionInitial extends BooksReactionState {}

final class BooksReactionLoading extends BooksReactionState {}

final class BooksReactionLoaded extends BooksReactionState {
  final ReactionEntity response;

  BooksReactionLoaded({required this.response});
}

final class BooksReactionError extends BooksReactionState {
  final String message;

  BooksReactionError({required this.message});
}