import '../../domain/entity/podcast_response_entity.dart';
import 'podcast_model.dart';

class PodcastResponseModel extends PodcastResponseEntity {
  const PodcastResponseModel({
    required bool success,
    required String message,
    required List<PodcastModel> data,
    required dynamic errors,
    required int code,
  }) : super(
    success: success,
    message: message,
    data: data,
    errors: errors,
    code: code,
  );

  factory PodcastResponseModel.fromJson(Map<String, dynamic> json) {
    return PodcastResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => PodcastModel.fromJson(item as Map<String, dynamic>))
          .toList() ??
          [],
      errors: json['errors'],
      code: json['code'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data.map((podcast) => (podcast as PodcastModel).toJson()).toList(),
    'errors': errors,
    'code': code,
  };
}