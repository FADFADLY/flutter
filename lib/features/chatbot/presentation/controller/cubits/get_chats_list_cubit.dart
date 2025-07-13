import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../core/services/local/chat_local_storage.dart';
import '../../../data/model/chat_list_response_model.dart';
import '../../../domain/entity/chat_item_entity.dart';
import '../../../domain/repo/repo.dart';

part 'get_chats_list_state.dart';

class GetChatsListCubit extends Cubit<GetChatsListState> {
  final ChatRepository chatRepository;
  final ChatLocalStorage localStorage;

  GetChatsListCubit({
    required this.chatRepository,
    required this.localStorage,
  }) : super(GetChatsListInitial());

  Future<void> getChatsList() async {
    emit(GetChatsListLoading());
    final result = await chatRepository.getChatsList();
    result.fold(
          (l) {
        emit(GetChatsListFailure(l.message));
      },
          (r) async {
        await localStorage.saveChatsList(ChatListResponseModel.fromEntity(r));
        emit(GetChatsListSuccess(r.chats));
      },
    );
  }
}