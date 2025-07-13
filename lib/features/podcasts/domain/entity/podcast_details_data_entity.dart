import 'episode_data_entity.dart';

class PodcastDetailsDataEntity {
  final String podcastId;
  final String title;
  final String publisher;
  final String image;
  final int totalEpisodes;
  final int nextEpisodePubDate;
  final List<EpisodeDataEntity> episodes;

  const PodcastDetailsDataEntity({
    required this.podcastId,
    required this.title,
    required this.publisher,
    required this.image,
    required this.totalEpisodes,
    required this.nextEpisodePubDate,
    required this.episodes,
  });
}