part of 'podcast_details_cubit.dart';

@immutable
sealed class PodcastDetailsState {}

final class PodcastDetailsInitial extends PodcastDetailsState {}

final class PodcastDetailsLoading extends PodcastDetailsState {}

final class PodcastDetailsLoadingAudio extends PodcastDetailsState {
  final PodcastDetailsDataEntity podcastDetails;
  final String episodeId;
  final bool isLoading;
  final double progressValue;
  final Duration position;
  final Duration duration;

  PodcastDetailsLoadingAudio({
    required this.podcastDetails,
    required this.episodeId,
    this.isLoading = false,
    this.progressValue = 0.0,
    this.position = Duration.zero,
    this.duration = Duration.zero,
  });
}

final class PodcastDetailsLoaded extends PodcastDetailsState {
  final PodcastDetailsDataEntity podcastDetails;
  final String? playingEpisodeId;
  final bool isPlaying;
  final bool isLoading;
  final double progressValue;
  final Duration position;
  final Duration duration;

  PodcastDetailsLoaded({
    required this.podcastDetails,
    this.playingEpisodeId,
    this.isPlaying = false,
    this.isLoading = false,
    this.progressValue = 0.0,
    this.position = Duration.zero,
    this.duration = Duration.zero,
  });
}

final class PodcastDetailsError extends PodcastDetailsState {
  final String message;

  PodcastDetailsError({required this.message});
}