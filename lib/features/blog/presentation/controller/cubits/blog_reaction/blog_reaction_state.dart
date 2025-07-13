part of 'blog_reaction_cubit.dart';

@immutable
sealed class BlogReactionState {}

final class BlogReactionInitial extends BlogReactionState {}
final class BlogReactionLoading extends BlogReactionState {}
final class BlogReactionSuccess extends BlogReactionState {
  final BlogReactionResponseEntity data;
  BlogReactionSuccess({required this.data});
}
final class BlogReactionError extends BlogReactionState {
  final String message;
  BlogReactionError({required this.message});

}