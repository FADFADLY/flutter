class LoginResponse {
  final bool success;
  final String message;
  final LoginResponseData? data;
  final LoginErrors? errors; // هنستخدم كلاس جديد للـ errors
  final int code;

  LoginResponse({
    required this.success,
    required this.message,
    this.data,
    this.errors,
    required this.code,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? 'An unknown error occurred',
      data: json['data'] != null ? LoginResponseData.fromJson(json['data']) : null,
      errors: json['errors'] != null ? LoginErrors.fromJson(json['errors']) : null,
      code: json['code'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
      'errors': errors?.toJson(),
      'code': code,
    };
  }
}

class LoginResponseData {
  final String token;

  LoginResponseData({
    required this.token,
  });

  factory LoginResponseData.fromJson(Map<String, dynamic> json) {
    return LoginResponseData(
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
    };
  }
}

class LoginErrors {
  final List<String> email;
  final List<String> password;

  LoginErrors({
    required this.email,
    required this.password,
  });

  factory LoginErrors.fromJson(dynamic json) {
    if (json is List) {
      // لو الـ errors هي list فاضية []
      return LoginErrors(
        email: [],
        password: [],
      );
    } else if (json is Map<String, dynamic>) {
      // لو الـ errors هي object زي {"password": ["كلمة المرور مطلوبة"], "email": []}
      return LoginErrors(
        email: List<String>.from(json['email'] ?? []),
        password: List<String>.from(json['password'] ?? []),
      );
    }
    return LoginErrors(email: [], password: []);
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}