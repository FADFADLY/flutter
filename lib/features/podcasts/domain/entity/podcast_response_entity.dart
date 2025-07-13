import 'podcast_data_entity.dart';

class PodcastResponseEntity {
  final bool success;
  final String message;
  final List<PodcastDataEntity> data;
  final dynamic errors;
  final int code;

  const PodcastResponseEntity({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
    required this.code,
  });
}