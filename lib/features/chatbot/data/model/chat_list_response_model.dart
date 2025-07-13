import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entity/chat_list_response_entity.dart';
import 'chat_item_model.dart';

part 'chat_list_response_model.g.dart';

@HiveType(typeId: 1)
class ChatListResponseModel extends ChatListResponseEntity {
  @HiveField(0)
  final bool success;
  @HiveField(1)
  final String message;
  @HiveField(2)
  final List<ChatItemModel> chatModels;
  @HiveField(3)
  final dynamic errors;
  @HiveField(4)
  final int code;

  const ChatListResponseModel({
    required this.success,
    required this.message,
    required this.chatModels,
    required this.errors,
    required this.code,
  }) : super(
    success: success,
    message: message,
    chats: chatModels,
    errors: errors,
    code: code,
  );

  factory ChatListResponseModel.fromJson(Map<String, dynamic> json) {
    final chatsList = (json['data'] as List<dynamic>)
        .map((e) => ChatItemModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return ChatListResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      chatModels: chatsList,
      errors: json['errors'],
      code: json['code'] as int,
    );
  }

  factory ChatListResponseModel.fromEntity(ChatListResponseEntity entity) {
    final chatsList = entity.chats
        .map((chatItemEntity) => ChatItemModel.fromEntity(chatItemEntity))
        .toList();

    return ChatListResponseModel(
      success: entity.success,
      message: entity.message,
      chatModels: chatsList,
      errors: entity.errors,
      code: entity.code,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': chatModels.map((chatItem) => chatItem.toJson()).toList(),
      'errors': errors,
      'code': code,
    };
  }
}