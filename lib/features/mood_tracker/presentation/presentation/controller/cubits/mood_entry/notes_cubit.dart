import 'package:bloc/bloc.dart';
import 'package:graduationproject/core/services/remote/mood_service.dart';
import 'package:meta/meta.dart';

import '../../../../../domain/entity/data_mood_entity.dart';
import '../../../../../domain/repo/repo.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit({required this.moodTrackerRepo}) : super(NotesInitial());
  final MoodTrackerRepo moodTrackerRepo;

  List<DataMoodEntity> moodList = [];
  Future<void> getNotes() async {
    emit(NotesLoading());
    final result = await moodTrackerRepo.getNotes();
    result.fold((l) {
      emit(NotesError( errorMessage:  l.message));
    }, (r) {
      moodList = r.data;
      print("moodList: $moodList");
emit(NotesLoaded(message: r.message));
    });
  }
}
