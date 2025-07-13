part of 'notes_cubit.dart';

@immutable
sealed class NotesState {}

final class NotesInitial extends NotesState {}


final class NotesLoading extends NotesState {}

final class NotesLoaded extends NotesState {
  final String message;
  NotesLoaded({required this.message});
}
final class NotesError extends NotesState {
  final String errorMessage;
  NotesError({required this.errorMessage});
}