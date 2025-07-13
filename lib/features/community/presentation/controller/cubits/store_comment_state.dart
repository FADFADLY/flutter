part of 'store_comment_cubit.dart';

@immutable
abstract class StoreCommentState {}

class CommentInitial extends StoreCommentState {}

class CommentLoading extends StoreCommentState {
  final int postId;
  final String commentContent;

  CommentLoading({required this.postId, required this.commentContent});
}

class CommentLoaded extends StoreCommentState {
  final String message;
  final int postId;
  final String commentContent;

  CommentLoaded({required this.message, required this.postId, required this.commentContent});
}

class CommentError extends StoreCommentState {
  final String message;
  final int postId;
  final String commentContent;

  CommentError({required this.message, required this.postId, required this.commentContent});
}