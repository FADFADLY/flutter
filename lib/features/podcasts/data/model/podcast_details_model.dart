import '../../domain/entity/podcast_details_data_entity.dart';
import 'episode_model.dart';

class PodcastDetailsModel extends PodcastDetailsDataEntity {
  const PodcastDetailsModel({
    required String podcastId,
    required String title,
    required String publisher,
    required String image,
    required int totalEpisodes,
    required int nextEpisodePubDate,
    required List<EpisodeModel> episodes,
  }) : super(
          podcastId: podcastId,
          title: title,
          publisher: publisher,
          image: image,
          totalEpisodes: totalEpisodes,
          nextEpisodePubDate: nextEpisodePubDate,
          episodes: episodes,
        );

  factory PodcastDetailsModel.fromJson(Map<String, dynamic> json) {
    return PodcastDetailsModel(
      podcastId: json['podcast_id'] ?? '',
      title: json['title'] ?? '',
      publisher: json['publisher'] ?? '',
      image: json['image'] ?? '',
      totalEpisodes: json['total_episodes'] ?? 0,
      nextEpisodePubDate: json['next_episode_pub_date'] ?? 0,
      episodes: (json['episodes'] as List<dynamic>?)
              ?.map((item) => EpisodeModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'podcast_id': podcastId,
        'title': title,
        'publisher': publisher,
        'image': image,
        'total_episodes': totalEpisodes,
        'next_episode_pub_date': nextEpisodePubDate,
        'episodes': episodes.map((episode) => (episode as EpisodeModel).toJson()).toList(),
      };
}