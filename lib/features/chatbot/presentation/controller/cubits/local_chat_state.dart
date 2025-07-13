part of 'local_chat_cubit.dart';

@immutable
abstract class LocalChatState {}

class LocalChatInitial extends LocalChatState {}

class LocalChatLoading extends LocalChatState {}

class LocalChatSuccess extends LocalChatState {
  final ChatMessagesApiResponseModel response;

  LocalChatSuccess({required this.response});
}

class LocalChatEmpty extends LocalChatState {}

class LocalChatError extends LocalChatState {
  final String message;

  LocalChatError({required this.message});
}