part of 'single_article_cubit.dart';

@immutable
sealed class SingleArticleState {}

final class SingleArticleInitial extends SingleArticleState {}

final class SingleArticleLoading extends SingleArticleState {}

final class SingleArticleLoaded extends SingleArticleState {
  final SingleArticle article;
  SingleArticleLoaded({required this.article});
}

final class SingleArticleError extends SingleArticleState {
  final String message;
  SingleArticleError({required this.message});
}
