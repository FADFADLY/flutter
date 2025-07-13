import 'package:dartz/dartz.dart';
import 'package:graduationproject/core/errors/failure.dart';
import 'package:graduationproject/features/mood_tracker/data/models/mood_tracker_request_modal.dart';
import 'package:graduationproject/features/mood_tracker/domain/entity/full_mood_response_entity.dart';
import 'package:graduationproject/features/mood_tracker/domain/entity/mood_tracker_response_entity.dart';
import 'package:graduationproject/core/errors/exceptions.dart';
import '../../../../core/services/remote/mood.dart';
import '../../../../core/services/remote/mood_service.dart';
import '../../domain/entity/daily_mood.dart';
import '../../domain/entity/data_mood_entity.dart';
import '../../domain/entity/monthly_moods_response_entity.dart';
import '../../domain/entity/mood_entry_entity.dart';
import '../../domain/repo/repo.dart';

class MoodTrackerRepoImpl extends MoodTrackerRepo {
  final MoodService moodService;

  MoodTrackerRepoImpl({required this.moodService });

  String _convertMoodToEmoji(String mood) {
    final cleanedMood = mood.trim().toLowerCase();

    switch (cleanedMood) {
      case 'none':
        return '\u{1F610}'; // 😐 Neutral
      case 'anger':
        return '\u{1F620}'; // 😠 Angry
      case 'joy':
        return '\u{1F604}'; // 😄 Joyful
      case 'sadness':
        return '\u{1F622}'; // 😢 Sad
      case 'love':
        return '\u{2764}';  // ❤️ Love
      case 'fear':
        return '\u{1F628}'; // 😨 Fear
      case 'sympathy':
        return '\u{1F917}'; // 🤗 Sympathy
      case 'surprise':
        return '\u{1F632}'; // 😲 Surprise
      default:
        return '\u{1F610}'; // 😐 Default to Neutral
    }


  }

  @override
  Future<Either<Failure, MoodEntryEntity>> createMoodEntry({
    required String notes,
  }) async {
    try {
      if (moodService == null) {
        throw GenericException(message: 'MoodServices is not initialized');
      }

      final response = await moodService.createMoodEntry(
        notes: notes,
      );
      if (response.success) {
        return Right(response);
      } else {
        return Left(ServerFailure(message: response.message, statusCode: response.code));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in createMoodEntry: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(message: "Failed to create mood entry: ${e.toString()}"));
    }
  }

  Future<Either<Failure, MonthlyMoodsResponseEntity>> getMonthlyMoods({
    required int month,
    required int year,
  }) async {
    try {
      final response = await moodService.getMonthlyMoods(
        month: month,
        year: year,
      );
      if (response.success) {
        return Right(response);
      } else {
        return Left(ServerFailure(message: response.message, statusCode: response.code));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in getMonthlyMoods: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(message: "Failed to get monthly moods: ${e.toString()}"));
    }
  }


  @override
  Future<Either<Failure, List<DailyMood>>> getWeaklyMoods(
      {required String weak}) async {
    try {
      final response = await moodService.getWeaklyMoods(week: weak);
      if (response.success) {
        final List<DataMoodEntity> entities = response.data ?? [];

        // فلترة للتأكد من عدم وجود أيام مكررة (نفس منطق الشهر)
        final Map<String, DataMoodEntity> filteredEntitiesMap = {};
        for (var entity in entities) {
          final String dayKey =
              "${entity.entryDate.year}-${entity.entryDate.month}-${entity.entryDate.day}";
          filteredEntitiesMap[dayKey] = entity;
        }

        // تحويل المزاج إلى إيموجي (نفس التحويل المستخدم في الشهر)
        final List<DailyMood> dailyMoods =
            filteredEntitiesMap.values.map((entity) {
          final convertedMood = _convertMoodToEmoji(entity.mood);
          return DailyMood(
            day: entity.entryDate.toString(), // أو أي تنسيق تفضله للتاريخ
            moodValue: convertedMood,
          );
        }).toList();

        return Right(dailyMoods);
      } else {
        return Left(ServerFailure(
            message: response.message, statusCode: response.code));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in getWeaklyMoods: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(
          message: "Failed to process weekly mood data: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, FullModeEntity>> getNotes() async {
    try {
      final response = await moodService.getNotes();
      if (response.success) {
        final List<DataMoodEntity> entities = response.data ?? [];
        print("Raw notes entities: $entities");

        // تطبيق تحويل الإيموجي فقط بدون تصفية الأيام المكررة
        final List<DataMoodEntity> entitiesWithEmoji = entities.map((entity) {
          final convertedMood = _convertMoodToEmoji(entity.mood);
          return DataMoodEntity(
            id: entity.id,
            entryDate: entity.entryDate,
            mood: convertedMood, // هنا يتم تطبيق التحويل
            feeling: entity.feeling,
            notes: entity.notes,
            dayOfWeek: entity.dayOfWeek,
          );
        }).toList();
print("Entities with emoji: ${response.data.map((e) => e.mood).toList()}");
        return Right(FullModeEntity(
          data: entitiesWithEmoji,
          success: response.success,
          message: response.message,
          errors: response.errors,
          code: response.code,
        ));
      } else {
        return Left(ServerFailure(
            message: response.message, statusCode: response.code));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in getNotes: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(
          message: "Failed to process notes data: ${e.toString()}"));
    }
  }



}
