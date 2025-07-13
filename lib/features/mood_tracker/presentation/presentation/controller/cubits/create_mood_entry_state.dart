part of 'create_mood_entry_cubit.dart';

abstract class CreateMoodEntryState {
  const CreateMoodEntryState();
}

class CreateMoodEntryInitial extends CreateMoodEntryState {}

class CreateMoodEntryLoading extends CreateMoodEntryState {}

class CreateMoodEntryLoaded extends CreateMoodEntryState {
  final MoodEntryEntity response;

  const CreateMoodEntryLoaded({required this.response});
}

class CreateMoodEntryError extends CreateMoodEntryState {
  final String message;

  const CreateMoodEntryError({required this.message});
}