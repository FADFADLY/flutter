import '../../domain/entity/podcast_data_entity.dart';

class PodcastModel extends PodcastDataEntity {
  const PodcastModel({
    required String podcastId,
    required String podcastName,
    required String publisher,
    required String image,
    required int episodesCount,
    required bool reacted,
  }) : super(
    reacted: reacted,
    podcastId: podcastId,
    podcastName: podcastName,
    publisher: publisher,
    image: image,
    episodesCount: episodesCount,
  );

  factory PodcastModel.fromJson(Map<String, dynamic> json) {
    return PodcastModel(
      reacted: json['reacted'] ?? false,
      podcastId: json['podcast_id'] ?? '',
      podcastName: json['podcast_name'] ?? '',
      publisher: json['publisher'] ?? '',
      image: json['image'] ?? '',
      episodesCount: json['episodes_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'podcast_id': podcastId,
    'podcast_name': podcastName,
    'publisher': publisher,
    'image': image,
    'episodes_count': episodesCount,
  };
}