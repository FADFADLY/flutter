import 'dart:convert';
import 'dart:io';
import 'package:graduationproject/features/community/data/models/update_post_model.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../../../config/cache/secure_cache_helper.dart';
import '../../../features/community/data/models/comment_model.dart';
import '../../../features/community/data/models/delete_comment_model.dart';
import '../../../features/community/data/models/delete_post_response_model.dart';
import '../../../features/community/data/models/get_comments_model.dart';
import '../../../features/community/data/models/post_response_model.dart';
import '../../../features/community/data/models/reaction_model.dart';
import '../../../features/community/data/models/store_post_response_model.dart';
import '../../../features/community/data/models/update_comment_response_model.dart';
import '../../../features/community/data/models/vote_response_model.dart';
import '../../../features/community/data/models/store_comment_response_model.dart';
import '../../errors/exceptions.dart';

class PostsService {
  static const String _baseUrl = 'https://progruad.website/fadfadly/public/api';

  Future<String?> _getToken() async {
    return await SecureCacheHelper.getString(key: "access_token");
  }

  Future<StorePostResponseModel> storePost({required String content}) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final uri = Uri.parse('$_baseUrl/posts');
      final request = http.MultipartRequest('POST', uri);

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';

      request.fields['content'] = content;
      print('Request Fields: ${request.fields}');

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return StorePostResponseModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else if (response.statusCode == 403) {
        throw ServerException(
          message: 'Forbidden: Access denied - ${response.body}',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to store post: ${response.statusCode} - ${response.body}',
          statusCode: response.statusCode,
        );
      }
    } catch (error, stackTrace) {
      print('Error in storePost: $error');
      print('Stack trace: $stackTrace');
      throw ServerException(message: 'Failed to store post: $error');
    }
  }

  Future<StorePostResponseModel> storePostWithImage({required String content, required File? image}) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final uri = Uri.parse('$_baseUrl/posts');
      final request = http.MultipartRequest('POST', uri);

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';
      request.fields['content'] = content;
      request.fields['type'] = 'image';
      request.files.add(await http.MultipartFile.fromPath('attachment', image!.path));

      print('Request Fields: ${request.fields}');
      print('Request Files: ${request.files.length}');

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return StorePostResponseModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else if (response.statusCode == 403) {
        throw ServerException(
          message: 'Forbidden: Access denied - ${response.body}',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to store post: ${response.statusCode} - ${response.body}',
          statusCode: response.statusCode,
        );
      }
    } catch (error, stackTrace) {
      print('Error in storePost: $error');
      print('Stack trace: $stackTrace');
      throw ServerException(message: 'Failed to store post: $error');
    }
  }

  Future<StorePostResponseModel> storePostWithFile({required String content, required File? file}) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final uri = Uri.parse('$_baseUrl/posts');
      final request = http.MultipartRequest('POST', uri);

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';
      request.fields['content'] = content;
      request.fields['type'] = 'file';
      request.files.add(await http.MultipartFile.fromPath('attachment', file!.path));
      print('Request Fields: ${request.fields}');
      print('Request Files: ${request.files.length}');

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return StorePostResponseModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else if (response.statusCode == 403) {
        throw ServerException(
          message: 'Forbidden: Access denied - ${response.body}',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to store post: ${response.statusCode} - ${response.body}',
          statusCode: response.statusCode,
        );
      }
    } catch (error, stackTrace) {
      print('Error in storePost: $error');
      print('Stack trace: $stackTrace');
      throw ServerException(message: 'Failed to store post: $error');
    }
  }
  Future<StorePostResponseModel> storePostWithAudio({required String content, required File? file}) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final uri = Uri.parse('$_baseUrl/posts');
      final request = http.MultipartRequest('POST', uri);

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';
      request.fields['content'] = content;
      request.fields['type'] = 'audio';
      request.files.add(await http.MultipartFile.fromPath('attachment', file!.path));
      print('Request Fields: ${request.fields}');
      print('Request Files: ${request.files.length}');

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return StorePostResponseModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else if (response.statusCode == 403) {
        throw ServerException(
          message: 'Forbidden: Access denied - ${response.body}',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to store post: ${response.statusCode} - ${response.body}',
          statusCode: response.statusCode,
        );
      }
    } catch (error, stackTrace) {
      print('Error in storePost: $error');
      print('Stack trace: $stackTrace');
      throw ServerException(message: 'Failed to store post: $error');
    }
  }

  Future<StorePostResponseModel> storePostWithPoll({required String content, required List<String> options}) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final uri = Uri.parse('$_baseUrl/posts');
      final request = http.MultipartRequest('POST', uri);

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';
      request.fields['content'] = content;
      request.fields['type'] = 'poll';
      request.fields['attachment'] = jsonEncode(options);

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return StorePostResponseModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else if (response.statusCode == 403) {
        throw ServerException(
          message: 'Forbidden: Access denied - ${response.body}',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to store post: ${response.statusCode} - ${response.body}',
          statusCode: response.statusCode,
        );
      }
    } catch (error, stackTrace) {
      print('Error in storePost: $error');
      print('Stack trace: $stackTrace');
      throw ServerException(message: 'Failed to store post: $error');
    }
  }

  Future<PostResponseModel> getPosts() async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/posts'),
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

  Future<VoteResponseModel> voteOnPost({required int postId, required int optionId}) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final uri = Uri.parse('$_baseUrl/posts/$postId/vote');
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'option_id': optionId,
        }),
      );

      print('Vote Request URL: $uri');
      print('Vote Response Status: ${response.statusCode}');
      print('Vote Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return VoteResponseModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else if (response.statusCode == 403) {
        throw ServerException(
          message: 'Forbidden: Access denied - ${response.body}',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to vote: ${response.statusCode} - ${response.body}',
          statusCode: response.statusCode,
        );
      }
    } catch (error, stackTrace) {
      print('Error in voteOnPost: $error');
      print('Stack trace: $stackTrace');
      throw ServerException(message: 'Failed to vote: $error');
    }
  }

  Future<PostReactionModel> reaction({required int postId, required String type}) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final uri = Uri.parse('$_baseUrl/reactions');
      final request = http.MultipartRequest('POST', uri);

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';

      request.fields['id'] = postId.toString();
      request.fields['type'] = type;

      print('Request Fields: ${request.fields}');

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return PostReactionModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else if (response.statusCode == 403) {
        throw ServerException(
          message: 'Forbidden: Access denied - ${response.body}',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to toggle reaction: ${response.statusCode} - ${response.body}',
          statusCode: response.statusCode,
        );
      }
    } catch (error, stackTrace) {
      print('Error in toggleReaction: $error');
      print('Stack trace: $stackTrace');
      throw ServerException(message: 'Failed to toggle reaction: $error');
    }
  }


  Future<StoreCommentResponseModel> storeComment({required int postId, required String commentContent}) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final uri = Uri.parse('$_baseUrl/posts/$postId/comments');
      final request = http.MultipartRequest('POST', uri);

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';

      request.fields['body'] = commentContent;

      print('Store Comment Request Fields: ${request.fields}');

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('Store Comment Response Status: ${response.statusCode}');
      print('Store Comment Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return StoreCommentResponseModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else if (response.statusCode == 408) {
        throw ServerException(
          message: 'Forbidden: Access denied - ${response.body}',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to store comment: ${response.statusCode} - ${response.body}',
          statusCode: response.statusCode,
        );
      }
    } catch (error, stackTrace) {
      print('Error in storeComment: $error');
      print('Stack trace: $stackTrace');
      throw ServerException(message: 'Failed to store comment: $error');
    }
  }

  Future<GetCommentsModel> getComments({required int postId}) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/posts/$postId/comments'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Get Comments Request URL: $_baseUrl/posts/$postId/comments');
      print('Get Comments Response Status: ${response.statusCode}');
      print('Get Comments Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return GetCommentsModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to fetch comments: ${response.statusCode} - ${response.body}',
          statusCode: response.statusCode,
        );
      }
    } catch (error, stackTrace) {
      print('Error in getComments: $error');
      print('Stack trace: $stackTrace');
      throw ServerException(message: 'Failed to fetch comments: $error');
    }
  }

  Future<DeletePostModel> deletePost({required int postId}) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final uri = Uri.parse('$_baseUrl/posts/$postId');
      final response = await http.delete(
        uri,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Delete Post Request URL: $uri');
      print('Delete Post Response Status: ${response.statusCode}');
      print('Delete Post Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        final responseData = jsonDecode(response.body);
        return DeletePostModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else if (response.statusCode == 403) {
        throw ServerException(
          message: 'Forbidden: Access denied - ${response.body}',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to delete post: ${response.statusCode} - ${response.body}',
          statusCode: response.statusCode,
        );
      }
    } catch (error, stackTrace) {
      print('Error in deletePost: $error');
      print('Stack trace: $stackTrace');
      throw ServerException(message: 'Failed to delete post: $error');
    }
  }
  Future<UpdateCommentResponseModel> updateComment({required int commentId, required String commentContent}) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final uri = Uri.parse('$_baseUrl/comments/$commentId');
      final response = await http.put(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'body': commentContent,
        }),
      );

      print('Update Comment Request URL: $uri');
      print('Update Comment Request Body: ${jsonEncode({'body': commentContent})}');
      print('Update Comment Response Status: ${response.statusCode}');
      print('Update Comment Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return UpdateCommentResponseModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else if (response.statusCode == 403) {
        throw ServerException(
          message: 'Forbidden: Access denied - ${response.body}',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to update comment: ${response.statusCode} - ${response.body}',
          statusCode: response.statusCode,
        );
      }
    } catch (error, stackTrace) {
      print('Error in updateComment: $error');
      print('Stack trace: $stackTrace');
      throw ServerException(message: 'Failed to update comment: $error');
    }
  }
  Future<DeleteCommentModel> deleteComment({required int commentId}) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final uri = Uri.parse('$_baseUrl/comments/$commentId');
      final response = await http.delete(
        uri,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Delete Comment Request URL: $uri');
      print('Delete Comment Response Status: ${response.statusCode}');
      print('Delete Comment Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        final responseData = jsonDecode(response.body);
        return DeleteCommentModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else if (response.statusCode == 403) {
        throw ServerException(
          message: 'Forbidden: Access denied - ${response.body}',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to delete comment: ${response.statusCode} - ${response.body}',
          statusCode: response.statusCode,
        );
      }
    } catch (error, stackTrace) {
      print('Error in deleteComment: $error');
      print('Stack trace: $stackTrace');
      throw ServerException(message: 'Failed to delete comment: $error');
    }
  }
  Future<UpdatePostModel > updatePost({required int postId, required String content}) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final uri = Uri.parse('$_baseUrl/posts/$postId');
      final response = await http.put(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'content': content,
        }),
      );

      print('Update Post Request URL: $uri');
      print('Update Post Request Body: ${jsonEncode({'content': content})}');
      print('Update Post Response Status: ${response.statusCode}');
      print('Update Post Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return UpdatePostModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else if (response.statusCode == 403) {
        throw ServerException(
          message: 'Forbidden: Access denied - ${response.body}',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to update post: ${response.statusCode} -thumbsup - ${response.body}',
          statusCode: response.statusCode,
        );
      }
    } catch (error, stackTrace) {
      print('Error in updatePost: $error');
      print('Stack trace: $stackTrace');
      throw ServerException(message: 'Failed to update post: $error');
    }
  }
}