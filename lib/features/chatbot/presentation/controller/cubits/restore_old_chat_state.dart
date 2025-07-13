part of 'restore_old_chat_cubit.dart';

@immutable
sealed class RestoreOldChatState {}

final class RestoreOldChatInitial extends RestoreOldChatState {}

final class RestoreOldChatLoading extends RestoreOldChatState {}

final class RestoreOldChatError extends RestoreOldChatState {
  final String message;
  RestoreOldChatError({required this.message});
}

final class RestoreOldChatSuccess extends RestoreOldChatState {

final  ChatMessagesApiResponseEntity chatMessagesApiResponseEntity;
  RestoreOldChatSuccess({required this.chatMessagesApiResponseEntity});
}
