import 'package:bloc/bloc.dart';
import 'package:graduationproject/features/mood_tracker/domain/entity/daily_mood.dart';
import 'package:meta/meta.dart';
import '../../../../../domain/entity/data_mood_entity.dart';
import '../../../../../domain/repo/repo.dart';
part 'weakly_mood_entry_state.dart';

class WeaklyMoodEntryCubit extends Cubit<WeaklyMoodEntryState> {
  WeaklyMoodEntryCubit({required this.moodTrackerRepo}) : super(WeaklyMoodEntryInitial());
  List<DailyMood> moodList = [];
  final MoodTrackerRepo moodTrackerRepo;
  DateTime? newFocusedWeak = DateTime.now();

  int getWeekOfYear(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysDifference = date.difference(firstDayOfYear).inDays;
    // نضمن إن الأسبوع يبدأ من الإثنين (ضبط الحساب)
    int adjustedDays = daysDifference + (firstDayOfYear.weekday - 1); // جعل الإثنين هو البداية
    int weekNumber = ((adjustedDays / 7) + 1).ceil(); // إضافة 1 عشان نعد الأسبوع الأول
    print("Calculated week: $weekNumber for date: $date (Adjusted days: $adjustedDays)");
    return weekNumber;
  }

  void updateNewFocusedWeak(int weekNumber, {int? year}) {
    final selectedYear = year ?? DateTime.now().year;
    DateTime firstDayOfYear = DateTime(selectedYear, 1, 1);
    int daysToAdd = (weekNumber - 1) * 7;
    DateTime startOfWeek = firstDayOfYear.add(Duration(days: daysToAdd));

    // نضمن إن الأسبوع يبدأ من الإثنين
    while (startOfWeek.weekday != DateTime.monday) {
      startOfWeek = startOfWeek.subtract(const Duration(days: 1));
    }

    newFocusedWeak = startOfWeek;
    print("Updated newFocusedWeak to: $newFocusedWeak for week: $weekNumber");
    emit(UpdateNewFocusedWeak());
  }

  Future<void> getMoods({required String weak}) async {
    emit(WeaklyMoodEntryLoading());
    final result = await moodTrackerRepo.getWeaklyMoods(weak: weak);
    result.fold(
          (l) {
        print("error: $l");
        emit(WeaklyMoodEntryError(message: l.message));
      },
          (r) {
        moodList = r;
        print("moodList: ${moodList.map((item) => item.day)}");
        emit(WeaklyMoodEntrySuccess(message: "success"));
      },
    );
  }
}