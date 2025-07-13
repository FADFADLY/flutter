import 'chat_item_entity.dart';

abstract class ChatListResponseEntity {
  final bool success;
  final String message;
  final List<ChatItemEntity> chats;
  final dynamic errors;
  final int code;

  const ChatListResponseEntity({
    required this.success,
    required this.message,
    required this.chats,
    required this.errors,
    required this.code,
  });
}