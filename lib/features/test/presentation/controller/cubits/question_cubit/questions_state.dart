
part of 'questions_cubit.dart';

@immutable
sealed class QuestionsState {}

final class QuestionsInitial extends QuestionsState {}
final class QuestionsLoading extends QuestionsState {}
final class QuestionsSuccess extends QuestionsState {
  final List<QuestionEntity> questions;
  QuestionsSuccess({required this.questions});
}
final class QuestionsError extends QuestionsState {
  final String message;
  QuestionsError({required this.message});
}
final class UpdateSelectedAnswer extends QuestionsState {



}
final class UpdatePageState extends QuestionsState {}