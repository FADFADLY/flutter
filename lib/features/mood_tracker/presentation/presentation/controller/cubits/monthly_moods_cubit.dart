import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/monthly_mood_entry_model.dart';
import '../../../../domain/entity/monthly_moods_response_entity.dart';
import '../../../../domain/repo/repo.dart';
part 'monthly_moods_state.dart';

class MonthlyMoodsCubit extends Cubit<MonthlyMoodsState> {
  final MoodTrackerRepo moodTrackerRepo;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  MonthlyMoodsCubit({required this.moodTrackerRepo}) : super(MonthlyMoodsInitial()) {
    fetchMonthlyMoods(month: _focusedDay.month, year: _focusedDay.year);
  }

  Future<void> fetchMonthlyMoods({
    required int month,
    required int year,
  }) async {
    emit(MonthlyMoodsLoading());
    final result = await moodTrackerRepo.getMonthlyMoods(
      month: month,
      year: year,
    );
    result.fold(
          (failure) => emit(MonthlyMoodsError(message: failure.message)),
          (response) => emit(MonthlyMoodsLoaded(response: response)),
    );
  }

  void updateFocusedDay(DateTime newFocusedDay) {
    _focusedDay = newFocusedDay;
    fetchMonthlyMoods(month: _focusedDay.month, year: _focusedDay.year);
    if (state is MonthlyMoodsLoaded) {
      emit(MonthlyMoodsLoaded(response: (state as MonthlyMoodsLoaded).response));
    }
  }

  void updateSelectedDay(DateTime selectedDay) {
    _selectedDay = selectedDay;
    if (state is MonthlyMoodsLoaded) {
      emit(MonthlyMoodsLoaded(response: (state as MonthlyMoodsLoaded).response));
    }
  }

  String getDailyMood(DateTime day) {
    if (state is MonthlyMoodsLoaded) {
      final loadedState = state as MonthlyMoodsLoaded;
      if (loadedState.response.data.isEmpty) {
        return ''; // لو مفيش داتا، يرجع سلسلة فارغة عشان الكاليندر يظهر فاضي
      }
      final entry = loadedState.response.data.firstWhere(
            (entry) => DateTime.parse(entry.entryDate).day == day.day &&
            DateTime.parse(entry.entryDate).month == day.month &&
            DateTime.parse(entry.entryDate).year == day.year,
        orElse: () => MonthlyMoodEntryModel(
          id: 0,
          entryDate: '',
          mood: '', // رجوع سلسلة فارغة بدل neutral عشان ما يظهرش إيموجي افتراضي
          feeling: '',
          notes: '',
          dayOfWeek: '',
        ),
      ) as MonthlyMoodEntryModel;
      return entry.mood;
    }
    return '';
  }

  DateTime get focusedDay => _focusedDay;
  DateTime? get selectedDay => _selectedDay;

  int getWeekOfYear(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysDifference = date.difference(firstDayOfYear).inDays;
    return ((daysDifference + firstDayOfYear.weekday) / 7).ceil();
  }
}

