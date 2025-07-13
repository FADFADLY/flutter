import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entity/mood_entry_entity.dart';
import '../../../../domain/repo/repo.dart';
part 'create_mood_entry_state.dart';

class CreateMoodEntryCubit extends Cubit<CreateMoodEntryState> {
  final MoodTrackerRepo moodTrackerRepo;

  CreateMoodEntryCubit({required this.moodTrackerRepo}) : super(CreateMoodEntryInitial());

  Future<void> createMoodEntry({
    required String mood,
    required String feeling,
    required String notes,
  }) async {
    emit(CreateMoodEntryLoading());
    final result = await moodTrackerRepo.createMoodEntry(

      notes: notes,
    );
    result.fold(
          (failure) => emit(CreateMoodEntryError(message: failure.message)),
          (response) => emit(CreateMoodEntryLoaded(response: response)),
    );
  }
}