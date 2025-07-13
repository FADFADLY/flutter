part of 'delete_comment_cubit.dart';

abstract class DeleteCommentState {
  const DeleteCommentState();
}

class DeleteCommentInitial extends DeleteCommentState {}

class DeleteCommentLoading extends DeleteCommentState {
  final int commentId;

  const DeleteCommentLoading({required this.commentId});
}

class DeleteCommentLoaded extends DeleteCommentState {
  final DeleteCommentEntity response;
  final int commentId;

  const DeleteCommentLoaded({required this.response, required this.commentId});
}

class DeleteCommentError extends DeleteCommentState {
  final String message;
  final int commentId;

  const DeleteCommentError({required this.message, required this.commentId});
}