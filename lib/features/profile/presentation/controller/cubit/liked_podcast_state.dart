part of 'liked_podcast_cubit.dart';

@immutable
sealed class LikedPodcastState {}

final class LikedPodcastInitial extends LikedPodcastState {}

final class LikedPodcastLoading extends LikedPodcastState {}

final class LikedPodcastLoaded extends LikedPodcastState {
  final List<PodcastDataEntity> podcasts;

  LikedPodcastLoaded({required this.podcasts});
}

final class LikedPodcastError extends LikedPodcastState {
  final String message;

  LikedPodcastError({required this.message});
}