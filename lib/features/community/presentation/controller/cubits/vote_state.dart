part of 'vote_cubit.dart';

@immutable
abstract class VoteState {}

class VoteInitial extends VoteState {}

class VoteLoading extends VoteState {
  final int postId;
  final int optionId;

  VoteLoading({required this.postId, required this.optionId});
}

class VoteLoaded extends VoteState {
  final String message;
  final int postId;
  final int optionId;

  VoteLoaded({required this.message, required this.postId, required this.optionId});
}

class VoteError extends VoteState {
  final String message;
  final int postId;
  final int optionId;

  VoteError({required this.message, required this.postId, required this.optionId});
}