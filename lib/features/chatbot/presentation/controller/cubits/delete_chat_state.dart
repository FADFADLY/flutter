part of 'delete_chat_cubit.dart';

@immutable
abstract class DeleteChatState {}

class DeleteChatInitial extends DeleteChatState {}

class DeleteChatLoading extends DeleteChatState {
  final int deletingChatId;

  DeleteChatLoading({required this.deletingChatId});
}

class DeleteChatSuccess extends DeleteChatState {
  final bool success;
  final String message;

  DeleteChatSuccess({required this.success, required this.message});
}

class DeleteChatError extends DeleteChatState {
  final String message;

  DeleteChatError({required this.message});
}