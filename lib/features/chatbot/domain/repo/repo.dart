import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entity/chat_list_response_entity.dart';
import '../entity/chat_response_entity.dart';
import '../entity/delete_chat_response_entity.dart';
import '../entity/chat_messages_api_response_entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, ChatResponseEntity>> createAndSend({
    required String userPrompt,
    int ? chatId,
  });

  Future<Either<Failure, ChatListResponseEntity>> getChatsList();

  Future<Either<Failure, DeleteChatResponseEntity>> deleteChat({
    required int id,
  });

  Future<Either<Failure, ChatMessagesApiResponseEntity>> getOldMessages({
    required int chatId,
  });
}