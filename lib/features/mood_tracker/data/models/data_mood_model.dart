
import '../../domain/entity/data_mood_entity.dart';

class DataMoodModel extends DataMoodEntity {
  DataMoodModel({
    required int id,
    required String entryDate,
    required String mood,
    required String? feeling,
    required String? notes,
    required String dayOfWeek,
  }) : super(
    id: id,
    entryDate: DateTime.parse(entryDate), // تحويل الـ String إلى DateTime
    mood: mood,
    feeling: feeling,
    notes: notes,
    dayOfWeek: dayOfWeek,
  );

  factory DataMoodModel.fromJson(Map<String, dynamic> json) {
    return DataMoodModel(
      id: json['id'] as int? ?? 0, // لو id null يحط 0
      entryDate: json['entry_date'] as String? ?? '2025', // قيمة افتراضية للتاريخ
      mood: json['mood'] as String? ?? 'love', // قيمة افتراضية للمزاج
      feeling: json['feeling'] as String? ?? '',
      notes: json['notes'] as String? ?? '',
      dayOfWeek: json['day_of_week'] as String? ?? 'Sat', // قيمة افتراضية لليوم
    );
  }

}