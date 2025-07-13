part of 'article_cubit.dart';

@immutable
sealed class ArticleState {}

final class ArticleInitial extends ArticleState {}
final class ArticleLoading extends ArticleState {}
final class ArticleLoaded extends ArticleState {
  final List<ArticleEntity> articles;
  ArticleLoaded({required this.articles});
}
final class ArticleError extends ArticleState {
  final String message;
  ArticleError({required this.message});}
