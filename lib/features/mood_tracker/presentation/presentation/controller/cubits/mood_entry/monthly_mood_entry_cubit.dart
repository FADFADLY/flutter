import 'package:bloc/bloc.dart';
import 'package:graduationproject/features/mood_tracker/domain/entity/mood_tracker_response_entity.dart';
import 'package:meta/meta.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../../core/constants/imports.dart';
import '../../../../../data/models/full_mood_response_modal.dart';
import '../../../../../domain/entity/data_mood_entity.dart';
import '../../../../../domain/repo/repo.dart';

part 'monthly_mood_entry_state.dart';

class MonthlyMoodEntryCubit extends Cubit<MonthlyMoodEntryState> {
  MonthlyMoodEntryCubit({required this.moodTrackerRepo}) : super(MoodEntryInitial());

  final PageController pageController = PageController(initialPage: 0);
  final MoodTrackerRepo moodTrackerRepo;
  List<DataMoodEntity> moodList = [];
  DateTime? newFocusedDay = DateTime.now();
  DateTime? selectedDay = DateTime.now();

  Future<void> getMoods({required  month, required  year}) async {
    emit(MoodEntryLoading());
    moodList.clear();

    try {
      final result = await moodTrackerRepo.getMonthlyMoods(month: month, year: year);

      result.fold(
            (l) => emit(MoodEntryError(message: l.message)),
            (r) {
          moodList = r.data  as List<DataMoodEntity>?? [];
          emit(MoodEntrySuccess(message: "success"));
        },
      );
    } catch (e) {
      emit(MoodEntryError(message: 'حدث خطأ أثناء جلب البيانات'));
    }
  }

  String getDailyMood({required DateTime day}) {
    for (var entry in moodList) {
      if (isSameDay(entry.entryDate, day)) {
        return entry.mood;
      }
    }
    return '';
  }

  void updatePageIndex(int index) {
    pageController.jumpToPage(index);
    emit(UpdatePageIndex());
  }

  void updateNewFocusedDay(DateTime newFocusedDay) {
    this.newFocusedDay = newFocusedDay;
    emit(UpdateNewFocusedDay());
  }

  void updateSelectedDay(DateTime newSelectedDay) {
    selectedDay = newSelectedDay;
    emit(UpdateSelectedDay());
  }

  @override
  Future<void> close() {
    pageController.dispose();
    moodList.clear();
    return super.close();
  }
}