import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entity/chat_messages_api_response_entity.dart';
import 'chat_message_model.dart';

part 'chat_messages_api_response_model.g.dart';

@HiveType(typeId: 5)
class ChatMessagesApiResponseModel extends ChatMessagesApiResponseEntity {
  @HiveField(0)
  final bool success;
  @HiveField(1)
  final String message;
  @HiveField(2)
  final List<ChatMessageModel> data;
  @HiveField(3)
  final dynamic errors;
  @HiveField(4)
  final int code;

  const ChatMessagesApiResponseModel({
    required this.success,
    required this.message,
    required this.data,
    this.errors,
    required this.code,
  }) : super(success: success, message: message, data: data, errors: errors, code: code);

  factory ChatMessagesApiResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatMessagesApiResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((item) => ChatMessageModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      errors: json['errors'],
      code: json['code'] as int,
    );
  }

  factory ChatMessagesApiResponseModel.fromEntity(ChatMessagesApiResponseEntity entity) {
    return ChatMessagesApiResponseModel(
      success: entity.success,
      message: entity.message,
      data: entity.data.map((e) => ChatMessageModel.fromEntity(e)).toList(),
      errors: entity.errors,
      code: entity.code,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((chat) => chat.toJson()).toList(),
      'errors': errors,
      'code': code,
    };
  }
}