import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entity/chat_response_entity.dart';
import '../../../domain/repo/repo.dart';
import '../../../data/model/chat_data_model.dart';
import '../../../data/model/chat_item_model.dart';
import 'package:logging/logging.dart';

import 'local_chat_cubit.dart';
import 'local_chats_list_cubit.dart';

part 'create_new_chat_state.dart';

class CreateAndSendCubit extends Cubit<CreateAndSendState> {
  final ChatRepository chatRepository;
  final LocalChatCubit localChatCubit;
  final LocalChatsListCubit localChatsListCubit;
  final Logger _logger = Logger('CreateAndSendCubit');

  CreateAndSendCubit({
    required this.chatRepository,
    required this.localChatCubit,
    required this.localChatsListCubit,
  }) : super(CreateAndSendInitial());

  Future<void> createNewChat({required String userPrompt, int? chatId}) async {
    if (isClosed) {
      _logger.warning('Cubit is closed, cannot create new chat');
      return;
    }
    emit(CreateAndSendLoading());
    try {
      _logger.info('Creating new chat with prompt: $userPrompt, chatId: $chatId');
      final result = await chatRepository
          .createAndSend(userPrompt: userPrompt, chatId: chatId)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw Exception('تجاوز وقت الانتظار للخادم');
      });
      result.fold(
            (l) {
          _logger.severe('Failed to create chat: ${l.message}');
          if (!isClosed) emit(CreateAndSendFailure(message: l.message));
        },
            (r) async {
          _logger.info('Chat created successfully, chatId: ${r.chatData?.chatId}');
          if (r.chatData != null && r.chatData?.chatId != null) {
            final chatDataModel = ChatDataModel.fromEntity(r.chatData!);
            _logger.info('Adding message to local storage for chatId: ${r.chatData?.chatId}');
            await localChatCubit.addLocalMessage(r.chatData!.chatId, chatDataModel);
            // Add new chat to local chats list
            final newChat = ChatItemModel(
              id: r.chatData!.chatId,
              title: userPrompt,
              dateTime: DateTime.now().toIso8601String(),
            );
            await localChatsListCubit.addLocalChat(newChat);
          } else {
            _logger.warning('No chatData or chatId returned from API');
          }
          if (!isClosed) emit(CreateAndSendSuccess(chatResponseEntity: r));
        },
      );
    } catch (e) {
      _logger.severe('Error creating chat: $e');
      if (!isClosed) emit(CreateAndSendFailure(message: e.toString()));
    }
  }
}