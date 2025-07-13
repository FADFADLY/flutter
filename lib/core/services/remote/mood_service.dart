import 'dart:convert';
import 'dart:io'; // عشان نستخدم SocketException لمشاكل الشبكة

import 'package:graduationproject/core/errors/exceptions.dart'; // استبدلي المسار بمسار ملف الـ Exceptions عندك
import 'package:graduationproject/features/mood_tracker/data/models/mood_tracker_response_model.dart';
import 'package:http/http.dart' as http;

import '../../../config/cache/secure_cache_helper.dart';
import '../../../features/mood_tracker/data/models/full_mood_response_modal.dart';
import '../../../features/mood_tracker/data/models/monthly_moods_response_model.dart';
import '../../../features/mood_tracker/data/models/mood_entry_model.dart';
import '../../../features/mood_tracker/data/models/mood_tracker_request_modal.dart';

class MoodService {
  final String baseUrl = 'https://progruad.website/fadfadly/public/api/';

  Future<String?> _getToken() async {
    return await SecureCacheHelper.getString(key: "access_token");
  }
  Future<MoodEntryModel> createMoodEntry({

    required String notes,
  }) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final uri = Uri.parse('${baseUrl}mood-entries');
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({

          'notes': notes,
        }),
      );

      print('Create Mood Entry Request URL: $uri');
      print('Create Mood Entry Request Body: ${jsonEncode({'notes': notes})}');
      print('Create Mood Entry Response Status: ${response.statusCode}');
      print('Create Mood Entry Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return MoodEntryModel.fromJson(responseData);
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
          message: 'Failed to create mood entry: ${response.statusCode} - ${response.body}',
          statusCode: response.statusCode,
        );
      }
    } catch (error, stackTrace) {
      print('Error in createMoodEntry: $error');
      print('Stack trace: $stackTrace');
      throw ServerException(message: 'Failed to create mood entry: $error');
    }
  }
  Future<MonthlyMoodsResponseModel> getMonthlyMoods({
    required int month,
    required int year,
  }) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final uri = Uri.parse('${baseUrl}mood-entries?month=$month&year=$year');
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print('Get Monthly Moods Request URL: $uri');
      print('Get Monthly Moods Response Status: ${response.statusCode}');
      print('Get Monthly Moods Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return MonthlyMoodsResponseModel.fromJson(responseData);
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
          message: 'Failed to get monthly moods: ${response.statusCode} - ${response.body}',
          statusCode: response.statusCode,
        );
      }
    } catch (error, stackTrace) {
      print('Error in getMonthlyMoods: $error');
      print('Stack trace: $stackTrace');
      throw ServerException(message: 'Failed to get monthly moods: $error');
    }
  }

  Future<FullMoodResponseModal> getWeaklyMoods({
    required String week,
  }) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final response = await http.get(
        Uri.parse('${baseUrl}mood-entries?week=$week&year=2025'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );


      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);

        // Add validation for the response structure
        if (responseData is! Map<String, dynamic>) {
          throw InvalidResponseException(
              message: 'Invalid response format: Expected a JSON object'
          );
        }

        return FullMoodResponseModal.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else if (response.statusCode == 404) {
        return FullMoodResponseModal(
          success: false,
          message: 'No moods found for the given period',
          data: [], errors: null, code: 404,
        );
      } else {
        throw ServerException(
          message: 'Failed to fetch moods: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      throw NetworkException(message: 'No internet connection. Please check your network.');
    } on FormatException catch (e) {
      throw InvalidResponseException(
          message: 'Invalid response format from server: ${e.message}'
      );
    } on http.ClientException {
      throw NetworkException(message: 'Network error occurred while fetching moods.');
    } catch (e, stackTrace) {
      print('Error in getMoods: $e');
      print('Stack trace: $stackTrace');
      throw GenericException(
          message: 'Error fetching moods: ${e.toString()}'
      );
    }
  }
  Future<FullMoodResponseModal> getNotes()async{
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final response = await http.get(
        Uri.parse('${baseUrl}mood-entries'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if(response.statusCode==200||response.statusCode==201){
        final responseData = jsonDecode(response.body);
        return FullMoodResponseModal.fromJson(responseData);
      }else if(response.statusCode==401){
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      }else if(response.statusCode==404){
        return FullMoodResponseModal(
          success: false,
          message: 'No moods found for the given period',
          data: [], errors: null, code: 404,
        );
      }else{
        throw ServerException(
          message: 'Failed to fetch moods: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      throw NetworkException(message: 'No internet connection. Please check your network.');
    } on FormatException catch (e) {
      throw InvalidResponseException(
          message: 'Invalid response format from server: ${e.message}'
      );
    } on http.ClientException {
      throw NetworkException(message: 'Network error occurred while fetching moods.');
    } catch (e, stackTrace) {
      print('Error in getMoods: $e');
      print('Stack trace: $stackTrace');
      throw GenericException(
          message: 'Error fetching moods: ${e.toString()}'
      );
    }
  }
}