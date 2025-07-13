import 'package:dartz/dartz.dart';
import 'package:graduationproject/features/chatbot/domain/entity/chat_list_response_entity.dart';
import 'package:graduationproject/features/chatbot/domain/entity/delete_chat_response_entity.dart';
import 'package:graduationproject/features/chatbot/domain/entity/chat_response_entity.dart';
import 'package:graduationproject/features/chatbot/domain/entity/chat_messages_api_response_entity.dart';
import 'package:graduationproject/core/errors/exceptions.dart';
import 'package:graduationproject/core/errors/failure.dart';
import '../../../../core/services/remote/chat_service.dart';
import '../../domain/repo/repo.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatBotService chatBotService;

  ChatRepositoryImpl({required this.chatBotService});

  @override
  Future<Either<Failure, ChatResponseEntity>> createAndSend({
    required String userPrompt,
    int ? chatId,
  }) async {
    try {
      final result = await chatBotService.createAndSend(userPrompt: userPrompt , chatId: chatId);
      if (result.isSuccess) {
        return Right(result);
      } else {
        return Left(GenericFailure(message: result.responseMessage));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in createNewChat: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(
          message: "فشل إنشاء الشات: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, ChatListResponseEntity>> getChatsList() async {
    try {
      final result = await chatBotService.getChatsList();
      if (result.success) {
        return Right(result);
      } else {
        return Left(GenericFailure(message: result.message));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in getChatsList: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(
          message: "فشل جلب ليستة الشاتس: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, DeleteChatResponseEntity>> deleteChat({
    required int id,
  }) async {
    try {
      final result = await chatBotService.deleteChat(id: id);
      if (result.success) {
        return Right(result);
      } else {
        return Left(GenericFailure(message: result.message));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in deleteChat: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(
          message: "فشل حذف الشات: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, ChatMessagesApiResponseEntity>> getOldMessages({
    required int chatId,
  }) async {
    try {
      final result = await chatBotService.getOldMessages(chatId: chatId);
      if (result.success) {
        return Right(result);
      } else {
        return Left(GenericFailure(message: result.message));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in getOldMessages: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(
          message: "فشل جلب الرسايل القديمة: ${e.toString()}"));
    }
  }
}