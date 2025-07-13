class ForgetPasswordResponse {
  final bool success;
  final String message;
  final List<dynamic>? data; // الـ data ممكن تكون [] أو null
  final ForgetPasswordErrors? errors; // الـ errors ممكن تكون [] أو object
  final int code;

  ForgetPasswordResponse({
    required this.success,
    required this.message,
    this.data,
    this.errors,
    required this.code,
  });

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? 'An unknown error occurred',
      data: json['data'] != null ? List<dynamic>.from(json['data']) : null,
      errors: json['errors'] != null ? ForgetPasswordErrors.fromJson(json['errors']) : null,
      code: json['code'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data,
      'errors': errors?.toJson(),
      'code': code,
    };
  }
}

class ForgetPasswordErrors {
  final List<String> email;

  ForgetPasswordErrors({
    required this.email,
  });

  factory ForgetPasswordErrors.fromJson(dynamic json) {
    if (json is List) {
      // لو الـ errors هي list فاضية []
      return ForgetPasswordErrors(
        email: [],
      );
    } else if (json is Map<String, dynamic>) {
      // لو الـ errors هي object زي {"email": ["البريد الالكتروني مطلوب"]}
      return ForgetPasswordErrors(
        email: List<String>.from(json['email'] ?? []),
      );
    }
    return ForgetPasswordErrors(email: []);
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}