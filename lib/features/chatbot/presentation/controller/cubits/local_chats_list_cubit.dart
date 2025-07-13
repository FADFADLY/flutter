import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/services/local/chat_local_storage.dart';
import '../../../data/model/chat_item_model.dart';
import '../../../data/model/chat_list_response_model.dart';
import '../../../domain/entity/chat_item_entity.dart';
import '../../../domain/repo/repo.dart';

part 'local_chats_list_state.dart';

class LocalChatsListCubit extends Cubit<LocalChatsListState> {
  final ChatLocalStorage localStorage;
  final ChatRepository chatRepository;

  LocalChatsListCubit({
    required this.localStorage,
    required this.chatRepository,
  }) : super(LocalChatsListInitial());

  Future<void> getLocalChatsList() async {
    emit(LocalChatsListLoading());
    try {
      // Fetch from API
      final apiResponse = await chatRepository.getChatsList();
      apiResponse.fold(
            (failure) async {
          // Handle API failure
          debugPrint('فشل fetch الشاتات من الـ API: ${failure.message}');
          // Fallback to local storage
          final localChats = await localStorage.getChatsList();
          if (localChats != null && localChats.chatModels.isNotEmpty) {
            emit(LocalChatsListSuccess(chats: localChats.chatModels));
            debugPrint('جبت ${localChats.chatModels.length} شات من Hive');
          } else {
            emit(LocalChatsListEmpty());
            debugPrint('قايمة الشاتات فاضية في Hive');
          }
        },
            (response) async {
          // Handle API success
          if (response.success && response.chats.isNotEmpty) {
            // Save to Hive
            final chatListResponse = ChatListResponseModel(
              success: response.success,
              message: response.message,
              chatModels: response.chats
                  .map((chat) => ChatItemModel.fromEntity(chat))
                  .toList(),
              errors: response.errors,
              code: response.code,
            );
            await localStorage.saveChatsList(chatListResponse);
            emit(LocalChatsListSuccess(chats: chatListResponse.chatModels));
            debugPrint('جبت ${chatListResponse.chatModels.length} شات من الـ API وحفظتهم في Hive');
          } else {
            // API returned empty or failed
            debugPrint('الـ API رجّع قايمة فاضية أو فشل: ${response.message}');
            // Fallback to local storage
            final localChats = await localStorage.getChatsList();
            if (localChats != null && localChats.chatModels.isNotEmpty) {
              emit(LocalChatsListSuccess(chats: localChats.chatModels));
              debugPrint('جبت ${localChats.chatModels.length} شات من Hive');
            } else {
              emit(LocalChatsListEmpty());
              debugPrint('قايمة الشاتات فاضية في الـ API وHive');
            }
          }
        },
      );
    } catch (e) {
      // Fallback to local storage on unexpected error
      debugPrint('خطأ غير متوقع في fetch الشاتات: $e');
      final localChats = await localStorage.getChatsList();
      if (localChats != null && localChats.chatModels.isNotEmpty) {
        emit(LocalChatsListSuccess(chats: localChats.chatModels));
        debugPrint('جبت ${localChats.chatModels.length} شات من Hive');
      } else {
        emit(LocalChatsListError(message: 'فشل جلب قايمة الشاتات: $e'));
        debugPrint('خطأ في جلب الشاتات وHive فاضي: $e');
      }
    }
  }

  Future<void> addLocalChat(ChatItemEntity chat) async {
    emit(LocalChatsListLoading());
    try {
      await localStorage.addChat(chat);
      final response = await localStorage.getChatsList();
      if (response == null || response.chatModels.isEmpty) {
        emit(LocalChatsListEmpty());
      } else {
        emit(LocalChatsListSuccess(chats: response.chatModels));
      }
      debugPrint('أضفت شات جديد: ${chat.id}');
    } catch (e) {
      emit(LocalChatsListError(message: 'فشل إضافة الشات: $e'));
      debugPrint('خطأ في إضافة الشات: $e');
    }
  }

  Future<void> updateLocalChatsList(List<ChatItemEntity> chats) async {
    emit(LocalChatsListLoading());
    try {
      await localStorage.saveChatsList(ChatListResponseModel(
        success: true,
        message: 'تم تحديث القايمة',
        chatModels: chats.map((e) => ChatItemModel.fromEntity(e)).toList(),
        errors: null,
        code: 200,
      ));
      emit(LocalChatsListSuccess(chats: chats));
      debugPrint('حدّثت قايمة الشاتات: ${chats.length} شات');
    } catch (e) {
      emit(LocalChatsListError(message: 'فشل تحديث قايمة الشاتات: $e'));
      debugPrint('خطأ في تحديث قايمة الشاتات: $e');
    }
  }
}