import 'dart:convert';
import 'package:graduationproject/features/community/data/models/post_response_model.dart';
import 'package:http/http.dart' as http;
import 'dart:io'; // Added for File handling

import '../../../config/cache/secure_cache_helper.dart';
import '../../../features/books/data/models/book_response_model.dart';
import '../../../features/podcasts/data/model/podcast_response_model.dart';
import '../../../features/profile/data/models/profile_response_model.dart';
import '../../../features/profile/data/models/update_avatar_model.dart';
import '../../../features/profile/data/models/update_bio_model.dart';
import '../../../features/profile/data/models/update_name_model.dart';
import '../../../features/profile/data/models/liked_items_response_model.dart'; // Added
import '../../errors/exceptions.dart';

class ProfileService {
  static const String _baseUrl = 'https://progruad.website/fadfadly/public/api';

  Future<String?> _getToken() async {
    return await SecureCacheHelper.getString(key: "access_token");
  }

  Future<ProfileResponseModel> getProfile() async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/profile'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return ProfileResponseModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to fetch profile: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } catch (e, stackTrace) {
      print('Error in getProfile: $e');
      print('Stack trace: $stackTrace');
      throw GenericException(message: 'Error fetching profile: $e');
    }
  }
  Future<UpdateNameResponseModel> updateName(String newName) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final response = await http.put(
        Uri.parse('$_baseUrl/profile/name'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'name': newName}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Response data: $responseData'); // للتحقق من الـ Response
        return UpdateNameResponseModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to update name: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } catch (e, stackTrace) {
      print('Error in updateName: $e');
      print('Stack trace: $stackTrace');
      throw GenericException(message: 'Error updating name: $e');
    }
  }
  Future<UpdateBioResponseModel> updateBio(String bio) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      print('Sending PUT request to $_baseUrl/profile/bio with body: {"bio": "$bio"}');
      final response = await http.put(
        Uri.parse('$_baseUrl/profile/bio'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'bio': bio,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Response data: $responseData'); // للتحقق من الـ Response
        return UpdateBioResponseModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to update bio: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } catch (e, stackTrace) {
      print('Error in updateBio: $e');
      print('Stack trace: $stackTrace');
      throw GenericException(message: 'Error updating bio: $e');
    }
  }
  Future<UpdateAvatarResponseModel> updateAvatar(File avatar) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      // Create a multipart request
      final request = http.MultipartRequest(
        'POST', // Assuming POST for file upload; change to PUT if required
        Uri.parse('$_baseUrl/profile/avatar'),
      );

      // Add headers
      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      // Add the image file to the request
      request.files.add(
        await http.MultipartFile.fromPath(
          'avatar', // Field name expected by the backend
          avatar.path,
          // Optionally specify contentType if needed
          // contentType: MediaType('image', 'jpeg'),
        ),
      );

      // Send the request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Response data: $responseData'); // للتحقق من الـ Response
        return UpdateAvatarResponseModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to update avatar: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } catch (e, stackTrace) {
      print('Error in updateAvatar: $e');
      print('Stack trace: $stackTrace');
      throw GenericException(message: 'Error updating avatar: $e');
    }
  }
  Future<LikedItemsResponseModel> getLikedItems({required String type}) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/liked-items?type=$type'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Response data: $responseData');
        return LikedItemsResponseModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to fetch liked items: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } catch (e, stackTrace) {
      print('Error in getLikedItems: $e');
      print('Stack trace: $stackTrace');
      throw GenericException(message: 'Error fetching liked items: $e');
    }
  }
  Future<PostResponseModel> getLikedPosts() async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/api/liked-items?type=post'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return PostResponseModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to fetch posts: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } catch (error, stackTrace) {
      print('Error in getPosts: $error');
      print('Stack trace: $stackTrace');
      throw ServerException(message: 'Failed to fetch posts: $error');
    }
  }
  Future<BookResponseModel> getLikedBooks() async {
    Future<String?> _getToken() async {
      return await SecureCacheHelper.getString(key: "access_token");
    }

    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/liked-items?type=book'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return BookResponseModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to fetch books: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } catch (e, stackTrace) {
      print('Error in getAllBooks: $e');
      print('Stack trace: $stackTrace');

      throw GenericException(message: 'Error fetching books: $e');
    }
  }
  Future<PodcastResponseModel> getLikedPodcasts() async {
    Future<String?> _getToken() async {
      return await SecureCacheHelper.getString(key: "access_token");
    }

    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final response = await http.get(
        Uri.parse('${_baseUrl}/liked-items?type=podcast'),
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


}