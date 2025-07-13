class CalculationRequestModel {
  final Map<String, int> answers;

  CalculationRequestModel({required this.answers});

  Map<String, dynamic> toJson() {
    return answers;
  }
}