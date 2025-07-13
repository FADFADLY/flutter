part of 'get_chats_list_cubit.dart';

@immutable
sealed class GetChatsListState {}

final class GetChatsListInitial extends GetChatsListState {}

final class GetChatsListSuccess extends GetChatsListState {
  final List<ChatItemEntity> chats;
  GetChatsListSuccess(this.chats);
}

final class GetChatsListFailure extends GetChatsListState {
  final String message;
  GetChatsListFailure(this.message);
}

final class GetChatsListLoading extends GetChatsListState {}
