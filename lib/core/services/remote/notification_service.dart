import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../config/cache/secure_cache_helper.dart';
import '../../../features/notifications/data/models/notification_model.dart';
import '../../errors/exceptions.dart';


class NotificationService {
  static const String _baseUrl = 'https://progruad.website/fadfadly/public/api';

  Future<String?> _getToken() async {
    return await SecureCacheHelper.getString(key: "access_token");
  }

  Future<NotificationModel> getNotifications() async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(message: 'Token not found. Please log in again.');
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/notifications'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Response data: $responseData'); // للتحقق من الـ Response
        return NotificationModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'Unauthorized: Invalid or expired token.',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'Failed to fetch notifications: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } catch (e, stackTrace) {
      print('Error in getNotifications: $e');
      print('Stack trace: $stackTrace');
      throw GenericException(message: 'Error fetching notifications: $e');
    }
  }
}