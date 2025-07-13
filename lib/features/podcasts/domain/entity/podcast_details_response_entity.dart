import 'podcast_details_data_entity.dart';

class PodcastDetailsResponseEntity {
  final bool success;
  final String message;
  final PodcastDetailsDataEntity data;
  final dynamic errors;
  final int code;

  const PodcastDetailsResponseEntity({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
    required this.code,
  });
}