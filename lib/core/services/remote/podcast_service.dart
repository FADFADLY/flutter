import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../config/cache/secure_cache_helper.dart';
import '../../../features/podcasts/data/model/podcast_response_model.dart';
import '../../../features/podcasts/data/model/podcast_details_response_model.dart';
import '../../../features/podcasts/data/model/reaction_model.dart';
import '../../../features/podcasts/domain/entity/reaction_entity.dart';
import '../../errors/exceptions.dart';

class PodcastService {
  static const String _baseUrl = 'https://progruad.website/fadfadly/public/api/';

  Future<PodcastResponseModel> getAllPodcasts() async {
    Future<String?> _getToken() async {
      return await SecureCacheHelper.getString(key: "access_token");
    }

    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final response = await http.get(
        Uri.parse('${_baseUrl}podcasts/'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return PodcastResponseModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to fetch podcasts: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } catch (e, stackTrace) {
      print('Error in getAllPodcasts: $e');
      print('Stack trace: $stackTrace');
      throw GenericException(message: 'Error fetching podcasts: $e');
    }
  }

  Future<ReactionModel> toggleReaction(String id) async {
    Future<String?> _getToken() async {
      return await SecureCacheHelper.getString(key: "access_token");
    }

    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final response = await http.post(
        Uri.parse('${_baseUrl}reactions'), // تأكد من الـ endpoint
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'id': id,
          'type': "podcast",
        }),
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return ReactionModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to toggle reaction: ${response.statusCode} - ${response.body}',
          statusCode: response.statusCode,
        );
      }
    } catch (e, stackTrace) {
      print('Error in toggleReaction: $e');
      print('Stack trace: $stackTrace');
      throw GenericException(message: 'Error toggling reaction: $e');
    }
  }

  Future<PodcastDetailsResponseModel> getPodcastDetails(String id) async {
    Future<String?> _getToken() async {
      return await SecureCacheHelper.getString(key: "access_token");
    }

    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final response = await http.get(
        Uri.parse('${_baseUrl}podcasts/$id'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return PodcastDetailsResponseModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to fetch podcast details: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } catch (e, stackTrace) {
      print('Error in getPodcastDetails: $e');
      print('Stack trace: $stackTrace');
      throw GenericException(message: 'Error fetching podcast details: $e');
    }
  }
}