part of 'reaction_cubit.dart';

@immutable
sealed class ReactionState {}

final class ReactionInitial extends ReactionState {}

final class ReactionLoading extends ReactionState {}

final class ReactionLoaded extends ReactionState {
  final ReactionEntity response;

  ReactionLoaded({required this.response});
}

final class ReactionError extends ReactionState {
  final String message;

  ReactionError({required this.message});
}