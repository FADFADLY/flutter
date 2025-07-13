class RegisterRequest {
  final String name;
  final String username;
  final String email;
  final String gender;
  final String age;
  final String password;
  final String passwordConfirmation;

  RegisterRequest({
    required this.name,
    required this.username,
    required this.email,
    required this.gender,
    required this.age,
    required this.password,
    required this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'username': username,
    'email': email,
    'gender': gender,
    'age': age,
    'password': password,
    'password_confirmation': passwordConfirmation,
  };
}
