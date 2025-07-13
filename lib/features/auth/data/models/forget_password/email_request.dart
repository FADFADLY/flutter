class ForgetPasswordRequest {
 final String email;

 ForgetPasswordRequest({
  required this.email,
 });

 factory ForgetPasswordRequest.fromJson(Map<String, dynamic> json) {
  return ForgetPasswordRequest(
   email: json['email'] ?? '',
  );
 }

 Map<String, dynamic> toJson() {
  return {
   'email': email,
  };
 }
}