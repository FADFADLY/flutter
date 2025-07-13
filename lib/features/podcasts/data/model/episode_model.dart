import '../../domain/entity/episode_data_entity.dart';

class EpisodeModel extends EpisodeDataEntity {
  const EpisodeModel({
    required String id,
    required String title,
    required String audio,
    required int durationMinutes,
    required String publishedAt,
    required String image,
    required String url,
  }) : super(
          id: id,
          title: title,
          audio: audio,
          durationMinutes: durationMinutes,
          publishedAt: publishedAt,
          image: image,
          url: url,
        );

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      audio: json['audio'] ?? '',
      durationMinutes: json['duration_minutes'] ?? 0,
      publishedAt: json['published_at'] ?? '',
      image: json['image'] ?? '',
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'audio': audio,
        'duration_minutes': durationMinutes,
        'published_at': publishedAt,
        'image': image,
        'url': url,
      };
}