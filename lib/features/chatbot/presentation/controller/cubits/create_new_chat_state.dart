part of 'create_new_chat_cubit.dart';


@immutable
abstract class CreateAndSendState {}

class CreateAndSendInitial extends CreateAndSendState {}

class CreateAndSendLoading extends CreateAndSendState {}

class CreateAndSendSuccess extends CreateAndSendState {
  final ChatResponseEntity chatResponseEntity;

  CreateAndSendSuccess({required this.chatResponseEntity});
}

class CreateAndSendFailure extends CreateAndSendState {
  final String message;

  CreateAndSendFailure({required this.message});
}