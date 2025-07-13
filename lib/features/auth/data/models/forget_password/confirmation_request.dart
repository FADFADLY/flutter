class ConfirmationRequest {
  final String email;
  final String password;
  final String passwordConfirmation;

  ConfirmationRequest({
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  // تحويل من JSON إلى Object
  factory ConfirmationRequest.fromJson(Map<String, dynamic> json) {
    return ConfirmationRequest(
      email: json['email'] as String,
      password: json['password'] as String,
      passwordConfirmation: json['password_confirmation'] as String,
    );
  }

  // تحويل من Object إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
  }
}