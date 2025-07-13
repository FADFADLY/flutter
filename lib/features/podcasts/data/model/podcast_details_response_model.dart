import '../../domain/entity/podcast_details_response_entity.dart';
import 'podcast_details_model.dart';

class PodcastDetailsResponseModel extends PodcastDetailsResponseEntity {
  const PodcastDetailsResponseModel({
    required bool success,
    required String message,
    required PodcastDetailsModel data,
    required dynamic errors,
    required int code,
  }) : super(
          success: success,
          message: message,
          data: data,
          errors: errors,
          code: code,
        );

  factory PodcastDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return PodcastDetailsResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: PodcastDetailsModel.fromJson(json['data'] as Map<String, dynamic>),
      errors: json['errors'],
      code: json['code'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': (data as PodcastDetailsModel).toJson(),
        'errors': errors,
        'code': code,
      };
}