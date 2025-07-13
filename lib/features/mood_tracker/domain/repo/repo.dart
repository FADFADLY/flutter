import 'package:dartz/dartz.dart';
import 'package:graduationproject/features/mood_tracker/domain/entity/mood_tracker_response_entity.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/mood_tracker_request_modal.dart';
import '../entity/daily_mood.dart';
import '../entity/full_mood_response_entity.dart';
import '../entity/monthly_moods_response_entity.dart';
import '../entity/mood_entry_entity.dart';

abstract class MoodTrackerRepo {
  Future<Either<Failure, MoodEntryEntity>> createMoodEntry({
    required String notes,
  });
  Future<Either<Failure, MonthlyMoodsResponseEntity>> getMonthlyMoods({
    required int month,
    required int year,
  });


  Future<Either<Failure, List<DailyMood>>> getWeaklyMoods({
    required String weak,
  });

  Future<Either<Failure, FullModeEntity>> getNotes();
}
