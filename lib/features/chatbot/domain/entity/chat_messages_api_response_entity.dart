import 'chat_message_entity.dart';

abstract class ChatMessagesApiResponseEntity {
  final bool success;
  final String message;
  final List<ChatMessageEntity> data;
  final dynamic errors;
  final int code;

  const ChatMessagesApiResponseEntity(
      {required this.success,
      required this.message,
      required this.data,
      required this.errors,
      required this.code});
}
