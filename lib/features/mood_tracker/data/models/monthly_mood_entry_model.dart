import '../../domain/entity/monthly_mood_entry_entity.dart';

class MonthlyMoodEntryModel extends MonthlyMoodEntryEntity {
  const MonthlyMoodEntryModel({
    required int id,
    required String entryDate,
    required String mood,
    required String feeling,
    required String notes,
    required String dayOfWeek,
  }) : super(
          id: id,
          entryDate: entryDate,
          mood: mood,
          feeling: feeling,
          notes: notes,
          dayOfWeek: dayOfWeek,
        );

  factory MonthlyMoodEntryModel.fromJson(Map<String, dynamic> json) {
    return MonthlyMoodEntryModel(
      id: json['id'] as int,
      entryDate: json['entry_date'] as String,
      mood: json['mood'] as String,
      feeling: json['feeling'] as String,
      notes: json['notes'] as String,
      dayOfWeek: json['day_of_week'] as String,
    );
  }
}