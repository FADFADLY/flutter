import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../config/cache/secure_cache_helper.dart';
import '../../../features/habits/data/models/habit_response_model.dart';
import '../../../features/habits/data/models/store_habits_response_model.dart';
import '../../errors/exceptions.dart';

class HabitService {
  static const String _baseUrl = 'https://progruad.website/fadfadly/public/api';

  Future<HabitResponseModel> getAllHabits() async {
    Future<String?> _getToken() async {
      return await SecureCacheHelper.getString(key: "access_token");
    }

    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/habits'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return HabitResponseModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to fetch habits: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } catch (e, stackTrace) {
      print('Error in getAllHabits: $e');
      print('Stack trace: $stackTrace');

      throw GenericException(message: 'Error fetching habits: $e');
    }
  }

  Future<StoreHabitsResponseModel> storeHabits(List<int> habits) async {
    Future<String?> _getToken() async {
      return await SecureCacheHelper.getString(key: "access_token");
    }

    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final response = await http.post(
        Uri.parse('$_baseUrl/habits'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'habits': habits,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return StoreHabitsResponseModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to store habits: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } catch (e, stackTrace) {
      print('Error in storeHabits: $e');
      print('Stack trace: $stackTrace');

      throw GenericException(message: 'Error storing habits: $e');
    }
  }
}
