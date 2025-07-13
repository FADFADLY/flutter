class MonthlyMoodEntryEntity {
  final int id;
  final String entryDate;
  final String mood;
  final String feeling;
  final String notes;
  final String dayOfWeek;

  const MonthlyMoodEntryEntity({
    required this.id,
    required this.entryDate,
    required this.mood,
    required this.feeling,
    required this.notes,
    required this.dayOfWeek,
  });
}