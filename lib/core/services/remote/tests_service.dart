import 'dart:convert';
import 'dart:io'; // عشان نستخدم SocketException لمشاكل الشبكة

import 'package:graduationproject/config/cache/secure_cache_helper.dart';
import 'package:graduationproject/core/errors/exceptions.dart'; // استبدلي المسار بمسار ملف الـ Exceptions عندك
import 'package:graduationproject/features/test/data/models/calculation_model/calculation_response_model.dart';
import 'package:graduationproject/features/test/data/models/question_response_model/question_test_modal.dart';
import 'package:http/http.dart' as http;

import '../../../features/test/data/models/calculation_model/calculation_request_model.dart';
import '../../../features/test/data/models/question_response_model/question_test_response_modal.dart';
import '../../../features/test/data/models/test_response_model/test_names_modal.dart';

class TestsService {
  final String _baseUrl = 'https://progruad.website/fadfadly/public/api/';

  Future<String?> _getToken() async {
    return await SecureCacheHelper.getString(key: "access_token");
  }

  Future<TestsNamesModel> getAllTestsName() async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
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
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to fetch tests: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      throw NetworkException(message: 'No internet connection. Please check your network.');
    } on FormatException {
      throw InvalidResponseException(message: 'Invalid response format from server.');
    } on http.ClientException {
      throw NetworkException(message: 'Network error occurred while fetching tests.');
    } catch (e) {
      throw GenericException(message: 'Error fetching tests: $e');
    }
  }

  Future<QuestionTestResponseModel> getAllQuestions(int id) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final response = await http.get(
        Uri.parse('${_baseUrl}tests/$id'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return QuestionTestResponseModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to fetch questions: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      throw NetworkException(message: 'No internet connection. Please check your network.');
    } on FormatException {
      throw InvalidResponseException(message: 'Invalid response format from server.');
    } on http.ClientException {
      throw NetworkException(message: 'Network error occurred while fetching questions.');
    } catch (e , stackTrace) {
      print('Error: $e');
      print('Stack Trace: $stackTrace');
      throw GenericException(message: 'Error fetching questions: $e');
    }
  }

  Future<CalculationResponseModel> calculate({
    required int testId,
    required CalculationRequestModel calculationRequestModel,
  }) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final response = await http.post(
        Uri.parse('${_baseUrl}tests/$testId'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(calculationRequestModel.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return CalculationResponseModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to submit calculation: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      throw NetworkException(message: 'No internet connection. Please check your network.');
    } on FormatException {
      throw InvalidResponseException(message: 'Invalid response format from server.');
    } on http.ClientException {
      throw NetworkException(message: 'Network error occurred while submitting calculation.');
    } catch (e) {
      throw GenericException(message: 'Error submitting calculation: $e');
    }
  }
}