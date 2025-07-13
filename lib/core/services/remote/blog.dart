import 'dart:convert';
import 'dart:io';

import 'package:graduationproject/features/blog/data/models/full_blog/blog_response_model.dart';
import 'package:graduationproject/features/blog/data/models/single_article/single_article_model.dart';
import 'package:http/http.dart' as http;

import '../../../config/cache/secure_cache_helper.dart';



import '../../../features/blog/data/models/blog_reaction/blog_reaction_response_model.dart';
import '../../../features/blog/data/models/single_article/single_artist_response_model.dart';
import '../../errors/exceptions.dart';

class BlogService {
  static const String _baseUrl = 'https://progruad.website/fadfadly/public/api';

  Future<BlogResponseModel> getAllBlogs() async {
    Future<String?> _getToken() async {
      return await SecureCacheHelper.getString(key: "access_token");
    }
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final response = await http.get(
        Uri.parse('${_baseUrl}/blogs'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return BlogResponseModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to fetch blogs: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    }  catch (e , stackTrace) {
      print('Error in getSingleBlog: $e');
      print('Stack trace: $stackTrace');

      throw GenericException(message: 'Error fetching blogs: $e');
    }
  }
  Future<SingleArticleResponseModel> getSingleBlog(int id) async {
    Future<String?> _getToken() async {
      return await SecureCacheHelper.getString(key: "access_token");
    }
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final response = await http.get(
        Uri.parse('${_baseUrl}/blogs/$id'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return SingleArticleResponseModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to fetch blogs: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } catch (e , stackTrace) {
      print('Error in getSingleBlog: $e');
      print('Stack trace: $stackTrace');

      throw GenericException(message: 'Error fetching blogs: $e');
    }
  }
  Future<BlogReactionResponseModel> postReaction({required int id}) async {

    Future<String?> _getToken() async {
      return await SecureCacheHelper.getString(key: "access_token");
    }

    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${_baseUrl}/reactions'),
      );

      // إضافة الـ form fields
      request.fields['id'] = id.toString();
      request.fields['type'] = "blog";

      // إضافة الـ Headers
      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedResponse = jsonDecode(responseBody);
        return BlogReactionResponseModel.fromJson(decodedResponse);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to post reaction: ${response.statusCode} - $responseBody',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      throw NetworkException(message: 'No internet connection. Please check your network.');
    }
    on FormatException {
      throw InvalidResponseException(message: 'Invalid response format from server.');
    }
    on HttpException {
      throw NetworkException(message: 'Network error occurred while posting reaction.');
    }


    on http.ClientException {
      throw NetworkException(message: 'Network error occurred while posting reaction.');
    } catch (e, stackTrace) {
      print('Error in postReaction: $e');
      print('Stack trace: $stackTrace');
      throw GenericException(message: 'Error posting reaction: ${e.toString()}');
    }
  }

}