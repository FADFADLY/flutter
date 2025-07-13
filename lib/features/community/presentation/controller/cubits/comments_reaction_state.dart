part of 'comments_reaction_cubit.dart';

@immutable
sealed class CommentsReactionState {
  final int? commentId;
  const CommentsReactionState({this.commentId});
}

final class CommentsReactionInitial extends CommentsReactionState {}

final class CommentsReactionLoading extends CommentsReactionState {
  const CommentsReactionLoading({required int commentId}) : super(commentId: commentId);
}

final class CommentsReactionLoaded extends CommentsReactionState {
  final String message;
  const CommentsReactionLoaded({required this.message, required int commentId})
      : super(commentId: commentId);
}

final class CommentsReactionError extends CommentsReactionState {
  final String message;
  const CommentsReactionError({required this.message, required int commentId})
      : super(commentId: commentId);
}