part of 'reaction_cubit.dart';

@immutable
sealed class PostsReactionState {
  final int? postId;
  const PostsReactionState({this.postId});
}

final class PostsReactionInitial extends PostsReactionState {}

final class PostsReactionLoading extends PostsReactionState {
  const PostsReactionLoading({required int postId}) : super(postId: postId);
}

final class PostsReactionLoaded extends PostsReactionState {
  final String message;
  const PostsReactionLoaded({required this.message, required int postId})
      : super(postId: postId);
}

final class PostsReactionError extends PostsReactionState {
  final String message;
  const PostsReactionError({required this.message, required int postId})
      : super(postId: postId);
}