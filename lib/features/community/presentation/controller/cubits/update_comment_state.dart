part of 'update_comment_cubit.dart';

@immutable
abstract class UpdateCommentState {
  final int? commentId;
  const UpdateCommentState({this.commentId});
}

class UpdateCommentInitial extends UpdateCommentState {}

class UpdateCommentLoading extends UpdateCommentState {
  const UpdateCommentLoading({required int commentId}) : super(commentId: commentId);
}

class UpdateCommentLoaded extends UpdateCommentState {
  final String message;
  const UpdateCommentLoaded({required this.message, required int commentId})
      : super(commentId: commentId);
}

class UpdateCommentError extends UpdateCommentState {
  final String message;
  const UpdateCommentError({required this.message, required int commentId})
      : super(commentId: commentId);
}