class VerifyCodeResponse {
  final bool success;
  final String message;
  final dynamic data; // لأن الـ data بترجع null
  final Errors? errors;
  final int code;

  VerifyCodeResponse({
    required this.success,
    required this.message,
    this.data,
    this.errors,
    required this.code,
  });

  factory VerifyCodeResponse.fromJson(Map<String, dynamic> json) {
    return VerifyCodeResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? 'An unknown error occurred',
      data: json['data'],
      errors: json['errors'] != null ? Errors.fromJson(json['errors']) : null,
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

class Errors {
  final List<String> code;

  Errors({
    required this.code,
  });

  factory Errors.fromJson(dynamic json) {
    if (json is List) {
      // لو الـ errors هي list فاضية []
      return Errors(
        code: [],
      );
    } else if (json is Map<String, dynamic>) {
      // لو الـ errors هي object زي {"code": ["رمز التحقق مطلوب"]}
      return Errors(
        code: List<String>.from(json['code'] ?? []),
      );
    }
    return Errors(code: []);
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
    };
  }
}