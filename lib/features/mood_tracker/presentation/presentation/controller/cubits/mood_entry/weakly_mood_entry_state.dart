part of 'weakly_mood_entry_cubit.dart';

@immutable
sealed class WeaklyMoodEntryState {}

final class WeaklyMoodEntryInitial extends WeaklyMoodEntryState {}

final class WeaklyMoodEntryLoading extends WeaklyMoodEntryState {}

final class WeaklyMoodEntrySuccess extends WeaklyMoodEntryState {
  final String message;

  WeaklyMoodEntrySuccess({required this.message});
}

final class WeaklyMoodEntryError extends WeaklyMoodEntryState {
  final String message;

  WeaklyMoodEntryError({required this.message});
}
final class UpdateNewFocusedWeak extends WeaklyMoodEntryState {}

