import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../config/cache/secure_cache_helper.dart';
import '../../../features/books/data/models/book_response_model.dart';
import '../../../features/books/data/models/book_details_model.dart';
import '../../../features/books/data/models/reaction_model.dart';
import '../../errors/exceptions.dart';

class BookService {
  static const String _baseUrl = 'https://progruad.website/fadfadly/public/api';

  Future<BookResponseModel> getAllBooks() async {
    Future<String?> _getToken() async {
      return await SecureCacheHelper.getString(key: "access_token");
    }

    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/books'),
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

  Future<BookDetailsModel> getBookDetails(int bookId) async {
    Future<String?> _getToken() async {
      return await SecureCacheHelper.getString(key: "access_token");
    }

    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/books/$bookId'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return BookDetailsModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to fetch book details: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } catch (e, stackTrace) {
      print('Error in getBookDetails: $e');
      print('Stack trace: $stackTrace');

      throw GenericException(message: 'Error fetching book details: $e');
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
        Uri.parse('${_baseUrl}/reactions'), // تأكد من الـ endpoint
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'id': id,
          'type': "book",
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

}