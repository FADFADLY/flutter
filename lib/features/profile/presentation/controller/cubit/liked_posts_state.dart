part of 'liked_posts_cubit.dart';


@immutable
sealed class LikedPostsState {}

final class GetLikedPostsInitial extends LikedPostsState {}

final class GetLikedPostsLoading extends LikedPostsState {}

final class GetLikedPostsLoaded extends LikedPostsState {
  final List<PostDataEntity> posts;
  GetLikedPostsLoaded({required this.posts});
}

final class GetLikedPostsError extends LikedPostsState {
  final String message;
  GetLikedPostsError({required this.message});
}
