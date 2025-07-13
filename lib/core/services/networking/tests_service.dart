import 'dart:convert';
import 'package:graduationproject/config/cache/secure_cache_helper.dart';
import 'package:graduationproject/features/test/data/models/question_response_model/question_test_modal.dart';
import 'package:http/http.dart' as http;

import '../../../features/test/data/models/question_response_model/question_test_response_modal.dart';
import '../../../features/test/data/models/test_response_model/test_names_modal.dart';

class TestsService {
  final String _baseUrl = 'https://progruad.website/fadfadly/public/api/';
  Future<String?> getToken() async {
    return await SecureCacheHelper.getString(key: "access_token");
  }
  Future<TestsNamesModel> getAllTestsName() async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('Token not found. Please log in again.');
      }
      final response = await http.get(
        Uri.parse('${_baseUrl}tests'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return TestsNamesModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid or expired token.');
      } else {
        throw Exception('Failed to fetch tests: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching tests: $e');
    }
  }
  Future<QuestionTestResponseModel> getAllQuestions(int id) async {
    try{
      final token = await getToken();
      if (token == null) {
        throw Exception('Token not found. Please log in again.');
      }

      final response = await http.get(
      Uri.parse('${_baseUrl}tests/$id'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        }
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return QuestionTestResponseModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid or expired token.');
      } else {
        throw Exception('Failed to fetch tests: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching tests: $e');
    }


    }
  }


