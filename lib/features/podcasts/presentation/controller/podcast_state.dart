part of 'podcast_cubit.dart';

@immutable
sealed class PodcastState {}

final class PodcastInitial extends PodcastState {}

final class PodcastLoading extends PodcastState {}

final class PodcastLoaded extends PodcastState {
  final List<PodcastDataEntity> podcasts;

  PodcastLoaded({required this.podcasts});
}

final class PodcastError extends PodcastState {
  final String message;

  PodcastError({required this.message});
}