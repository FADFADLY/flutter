part of 'mood_tracker_cubit.dart';


@immutable
sealed class MoodTrackerState {}

final class MoodTrackerInitial extends MoodTrackerState {}

final class MoodTrackerPostSuccess extends MoodTrackerState {
  final MoodEntryEntity moodEntryEntity;
  MoodTrackerPostSuccess({required this.moodEntryEntity});
}

final class MoodTrackerPostError extends MoodTrackerState {
  final String message;
  MoodTrackerPostError({required this.message});
}

final class MoodTrackerPostLoading extends MoodTrackerState {}

final class MoodTrackerUpdateEmotion extends MoodTrackerState {}