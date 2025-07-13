class VerifyCodeRequest {
  final int code;
final String email;
  VerifyCodeRequest({
    required this.email,
    required this.code,
  });

  factory VerifyCodeRequest.fromJson(Map<String, dynamic> json) {
    return VerifyCodeRequest(
      email: json['email'] ?? '',
      code: json['code'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'email': email,
    };
  }
}