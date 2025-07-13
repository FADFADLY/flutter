import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../core/services/local/chat_local_storage.dart';
import '../../../data/model/chat_messages_api_response_model.dart';
import '../../../data/model/chat_data_model.dart';

part 'local_chat_state.dart';

class LocalChatCubit extends Cubit<LocalChatState> {
  final ChatLocalStorage localStorage;

  LocalChatCubit({required this.localStorage}) : super(LocalChatInitial());

  Future<void> getLocalMessages(int chatId) async {
    emit(LocalChatLoading());
    try {
      final response = await localStorage.getResponse(chatId);
      if (response == null || response.data.isEmpty) {
        emit(LocalChatEmpty());
      } else {
        emit(LocalChatSuccess(response: response));
      }
    } catch (e) {
      emit(LocalChatError(message: 'فشل جلب الرسايل المحلية: $e'));
    }
  }

  Future<void> addLocalMessage(int chatId, ChatDataModel chatData) async {
    emit(LocalChatLoading());
    try {
      await localStorage.addMessageFromChatData(chatId, chatData);
      final response = await localStorage.getResponse(chatId);
      if (response == null || response.data.isEmpty) {
        emit(LocalChatEmpty());
      } else {
        emit(LocalChatSuccess(response: response));
      }
    } catch (e) {
      emit(LocalChatError(message: 'فشل إضافة الرسالة: $e'));
    }
  }
}