import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../core/services/local/chat_local_storage.dart';
import '../../../data/model/chat_messages_api_response_model.dart';
import '../../../domain/entity/chat_messages_api_response_entity.dart';
import '../../../domain/repo/repo.dart';
import 'local_chat_cubit.dart';

part 'restore_old_chat_state.dart';

class RestoreOldChatCubit extends Cubit<RestoreOldChatState> {
  final ChatRepository chatRepository;
  final ChatLocalStorage localStorage;
  final LocalChatCubit localChatCubit;

  RestoreOldChatCubit({
    required this.chatRepository,
    required this.localChatCubit,
  })  : localStorage = ChatLocalStorage(),
        super(RestoreOldChatInitial());

  Future<void> getOldMessages({required int chatId}) async {
    emit(RestoreOldChatLoading());
    final result = await chatRepository.getOldMessages(chatId: chatId);

    result.fold(
          (l) => emit(RestoreOldChatError(message: l.message)),
          (r) async {
        await localStorage.saveResponse(chatId, ChatMessagesApiResponseModel.fromEntity(r));
        emit(RestoreOldChatSuccess(chatMessagesApiResponseEntity: r));
        localChatCubit.getLocalMessages(chatId);
      },
    );
  }
}
