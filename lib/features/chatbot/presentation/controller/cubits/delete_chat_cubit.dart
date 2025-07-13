import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import '../../../../../core/services/local/chat_local_storage.dart';
import '../../../domain/repo/repo.dart';
import 'local_chats_list_cubit.dart';

part 'delete_chat_state.dart';

class DeleteChatCubit extends Cubit<DeleteChatState> {
  final ChatRepository chatRepository;
  final ChatLocalStorage localStorage;
  final LocalChatsListCubit localChatsListCubit;
  int? deletingChatId;

  DeleteChatCubit({
    required this.chatRepository,
    required this.localStorage,
    required this.localChatsListCubit,
  }) : super(DeleteChatInitial());

  Future<void> deleteChat({required int id}) async {
    deletingChatId = id;
    emit(DeleteChatLoading(deletingChatId: id));

    final result = await chatRepository.deleteChat(id: id);
    result.fold(
          (failure) {
        deletingChatId = null;
        emit(DeleteChatError(message: failure.message));
        debugPrint('فشل حذف الشات $id من الـ API: ${failure.message}');
      },
          (response) async {
        await localStorage.deleteChat(id);
        // Refresh the chats list
        await localChatsListCubit.getLocalChatsList();
        deletingChatId = null;
        emit(DeleteChatSuccess(
          success: response.success,
          message: response.message,
        ));
        debugPrint('حذفت الشات $id من الـ API وHive وحدّثت القايمة');
      },
    );
  }
}