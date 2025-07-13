class DataMoodEntity {
  final int id;
  final DateTime entryDate;
  final String mood;
  final String? feeling;
  final String? notes;
  final String dayOfWeek;

  const DataMoodEntity({
    required this.id,
    required this.entryDate,
    required this.mood,
    required this.feeling,
    required this.notes,
    required this.dayOfWeek,
  });
}