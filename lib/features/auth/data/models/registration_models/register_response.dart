

class RegisterResponse {
  final bool success;
  final String message;
  final List<dynamic>? data; // لأن الـ data بترجع [] أو null
  final Errors? errors;
  final int code;

  RegisterResponse({
    required this.success,
    required this.message,
    this.data,
    this.errors,
    required this.code,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? 'An unknown error occurred',
      data: json['data'], //
      errors: json['errors'] != null ? Errors.fromJson(json['errors']) : null,
      code: json['code'] ?? 0,
    );
  }


}
class Errors {
  final List<String> username;
  final List<String> email;
  final List<String> name;
  final List<String> gender;
  final List<String> age;
  final List<String> password;

  Errors({
    required this.username,
    required this.email,
    required this.name,
    required this.gender,
    required this.age,
    required this.password,
  });

  factory Errors.fromJson(Map<String, dynamic> json) {

    return Errors(
      username: List<String>.from(json['username'] ?? []),
      email: List<String>.from(json['email'] ?? []),
      name: List<String>.from(json['name'] ?? []),
      gender: List<String>.from(json['gender'] ?? []),
      age: List<String>.from(json['age'] ?? []),
      password: List<String>.from(json['password'] ?? []),
    );
  }

}