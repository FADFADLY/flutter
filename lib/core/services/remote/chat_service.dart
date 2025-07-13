import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:graduationproject/config/cache/secure_cache_helper.dart';
import 'package:graduationproject/core/errors/exceptions.dart';
import 'package:graduationproject/features/chatbot/data/model/chat_messages_api_response_model.dart';
import 'package:graduationproject/features/chatbot/data/model/delete_chat_response_model.dart';
import 'package:graduationproject/features/chatbot/data/model/chat_response_model.dart';
import 'package:graduationproject/features/chatbot/data/model/chat_list_response_model.dart';

class ChatBotService {
  final String _baseUrl = 'https://progruad.website/fadfadly/public/api/';

  Future<String?> _getToken() async {
    return await SecureCacheHelper.getString(key: "access_token");
  }

  Future<ChatResponseModel> createAndSend(
      {required String userPrompt, int? chatId}) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(
            message: 'التوكين مش موجود. لازم تسجل دخول تاني.');
      }
      final response = await http.post(
        Uri.parse('${_baseUrl}chatbot/send'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'prompt': userPrompt, if (chatId != null) 'chat_id': chatId}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return ChatResponseModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'غير مصرح: التوكين غلط أو منتهي.',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'فشل إنشاء الشات: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      throw NetworkException(message: 'مفيش نت. اتأكد من الشبكة بتاعتك.');
    } on FormatException {
      throw InvalidResponseException(
          message: 'فورمات الريسبونس غلط من السيرفر.');
    } on http.ClientException {
      throw NetworkException(message: 'فيه مشكلة في الشبكة أثناء إنشاء الشات.');
    } catch (e, stackTrace) {
      print('Error: $e');
      print('Stack Trace: $stackTrace');

      throw GenericException(message: 'خطأ في إنشاء الشات: $e');
    }
  }

  Future<ChatListResponseModel> getChatsList() async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(
            message: 'التوكين مش موجود. لازم تسجل دخول تاني.');
      }

      final response = await http.get(
        Uri.parse('${_baseUrl}chatbot/chats'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return ChatListResponseModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'غير مصرح: التوكين غلط أو منتهي.',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'فشل جلب ليستة الشاتس: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      throw NetworkException(message: 'مفيش نت. اتأكد من الشبكة بتاعتك.');
    } on FormatException {
      throw InvalidResponseException(
          message: 'فورمات الريسبونس غلط من السيرفر.');
    } on http.ClientException {
      throw NetworkException(
          message: 'فيه مشكلة في الشبكة أثناء جلب ليستة الشاتس.');
    } catch (e) {
      throw GenericException(message: 'خطأ في جلب ليستة الشاتس: $e');
    }
  }

  Future<DeleteChatResponseModel> deleteChat({required int id}) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(
            message: 'التوكين مش موجود. لازم تسجل دخول تاني.');
      }

      final response = await http.delete(
        Uri.parse('${_baseUrl}chatbot/chats/$id'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return DeleteChatResponseModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'غير مصرح: التوكين غلط أو منتهي.',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'فشل حذف الشات: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      throw NetworkException(message: 'مفيش نت. اتأكد من الشبكة بتاعتك.');
    } on FormatException {
      throw InvalidResponseException(
          message: 'فورمات الريسبونس غلط من السيرفر.');
    } on http.ClientException {
      throw NetworkException(message: 'فيه مشكلة في الشبكة أثناء حذف الشات.');
    } catch (e) {
      throw GenericException(message: 'خطأ في حذف الشات: $e');
    }
  }

  Future<ChatMessagesApiResponseModel> getOldMessages(
      {required int chatId}) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw GenericException(
            message: 'التوكين مش موجود. لازم تسجل دخول تاني.');
      }

      final response = await http.get(
        Uri.parse('${_baseUrl}chatbot/chats/$chatId'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return ChatMessagesApiResponseModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        throw ServerException(
          message: 'غير مصرح: التوكين غلط أو منتهي.',
          statusCode: response.statusCode,
        );
      } else {
        throw ServerException(
          message: 'فشل جلب الرسايل القديمة: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      throw NetworkException(message: 'مفيش نت. اتأكد من الشبكة بتاعتك.');
    } on FormatException {
      throw InvalidResponseException(
          message: 'فورمات الريسبونس غلط من السيرفر.');
    } on http.ClientException {
      throw NetworkException(
          message: 'فيه مشكلة في الشبكة أثناء جلب الرسايل القديمة.');
    } catch (e, s) {
      print(s);
      throw GenericException(message: 'خطأ في جلب الرسايل القديمة: $e');
    }
  }
}
