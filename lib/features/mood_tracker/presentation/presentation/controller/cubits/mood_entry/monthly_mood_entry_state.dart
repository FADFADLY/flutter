part of 'monthly_mood_entry_cubit.dart';

@immutable
sealed class MonthlyMoodEntryState {}

final class MoodEntryInitial extends MonthlyMoodEntryState {}

final class MoodEntryLoading extends MonthlyMoodEntryState {}

final class MoodEntrySuccess extends MonthlyMoodEntryState {
  final String message;

  MoodEntrySuccess({required this.message});
}

final class MoodEntryError extends MonthlyMoodEntryState {
  final String message;

  MoodEntryError({required this.message});
}

final class UpdateNewFocusedDay extends MonthlyMoodEntryState {}

final class UpdateSelectedDay extends MonthlyMoodEntryState {}

final class UpdatePageIndex extends MonthlyMoodEntryState {} // إضافة الـ state الجديد