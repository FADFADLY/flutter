import 'chat_data_entity.dart';

class ChatResponseEntity {
  final bool isSuccess;
  final String responseMessage;
  final ChatDataEntity? chatData;
  final dynamic errorDetails;
  final int statusCode;

 const ChatResponseEntity({
    required this.isSuccess,
    required this.responseMessage,
    this.chatData,
    this.errorDetails,
    required this.statusCode,
  });
}