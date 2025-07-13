class EpisodeDataEntity {
  final String id;
  final String title;
  final String audio;
  final int durationMinutes;
  final String publishedAt;
  final String image;
  final String url;

  const EpisodeDataEntity({
    required this.id,
    required this.title,
    required this.audio,
    required this.durationMinutes,
    required this.publishedAt,
    required this.image,
    required this.url,
  });
}