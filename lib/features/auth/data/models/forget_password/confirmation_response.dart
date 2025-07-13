class ConfirmationResponse {
  final bool success;
  final String message;
  final List<dynamic> data; // أو يمكن تكون List<Map<String, dynamic>> لو فيه بيانات لاحقًا
  final dynamic errors; // nullable لأنه بيكون null في الـ JSON
  final int code;

  ConfirmationResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
    required this.code,
  });

  // تحويل من JSON إلى Object
  factory ConfirmationResponse.fromJson(Map<String, dynamic> json) {
    return ConfirmationResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] as List<dynamic>,
      errors: json['errors'],
      code: json['code'] as int,
    );
  }

  // تحويل من Object إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data,
      'errors': errors,
      'code': code,
    };
  }
}