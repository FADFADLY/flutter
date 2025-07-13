part of 'local_chats_list_cubit.dart';

@immutable
abstract class LocalChatsListState {}

class LocalChatsListInitial extends LocalChatsListState {}

class LocalChatsListLoading extends LocalChatsListState {}

class LocalChatsListSuccess extends LocalChatsListState {
  final List<ChatItemEntity> chats;

  LocalChatsListSuccess({required this.chats});
}

class LocalChatsListEmpty extends LocalChatsListState {}

class LocalChatsListError extends LocalChatsListState {
  final String message;

  LocalChatsListError({required this.message});
}