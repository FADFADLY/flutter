part of 'get_posts_cubit.dart';

@immutable
sealed class GetPostsState {}

final class GetPostsInitial extends GetPostsState {}

final class GetPostsLoading extends GetPostsState {}

final class GetPostsLoaded extends GetPostsState {
  final List<PostDataEntity> posts;
  GetPostsLoaded({required this.posts});
}

final class GetPostsError extends GetPostsState {
  final String message;
  GetPostsError({required this.message});
}