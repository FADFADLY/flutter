class LoginRequest {
  String? email;
  String? password;

  LoginRequest({this.email, this.password});

 Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
  };
}
