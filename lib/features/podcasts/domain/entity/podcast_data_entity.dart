class PodcastDataEntity {
  final String podcastId;
  final String podcastName;
  final String publisher;
  final String image;
  final int episodesCount;
  final bool reacted;

  const PodcastDataEntity({
    required this.podcastId,
    required this.podcastName,
    required this.publisher,
    required this.image,
    required this.episodesCount,
    required this.reacted,
  });
}