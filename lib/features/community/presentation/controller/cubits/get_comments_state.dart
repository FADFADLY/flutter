part of 'get_comments_cubit.dart';

abstract class CommentsState {
  const CommentsState();
}

class CommentsInitial extends CommentsState {}

class CommentsLoading extends CommentsState {
  final int postId;

  const CommentsLoading({required this.postId});
}

class CommentsLoaded extends CommentsState {
  final GetCommentsEntity response;
  final int postId;

  const CommentsLoaded({required this.response, required this.postId});
}

class CommentsError extends CommentsState {
  final String message;
  final int postId;

  const CommentsError({required this.message, required this.postId});
}