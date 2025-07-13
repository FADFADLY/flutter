class MoodTrackerRequestModel {
  final String mood;
  final String feeling;
  final String notes;

  MoodTrackerRequestModel({
    required this.mood,
    required this.feeling,
    required this.notes,
  });

  // تحويل الكلاس إلى Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'mood': mood,
      'feeling': feeling,
      'notes': notes,
    };
  }
}