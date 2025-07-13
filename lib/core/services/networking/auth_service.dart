import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/features/auth/data/models/forget_password/code_response.dart';
import 'package:graduationproject/features/auth/data/models/forget_password/confirmation_response.dart';
import 'package:graduationproject/features/auth/data/models/forget_password/email_response.dart';
import 'package:http/http.dart' as http;

import '../../../features/auth/data/models/forget_password/code_request.dart';
import '../../../features/auth/data/models/forget_password/confirmation_request.dart';
import '../../../features/auth/data/models/forget_password/email_request.dart';

class AuthService {
  static const String _baseUrl = 'https://progruad.website/fadfadly/public/api';

  Future<RegisterResponse> register(RegisterRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.body.isEmpty) {
        throw InvalidResponseException(
            message: 'Registration failed: No response from server');
      }

      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse is! Map<String, dynamic>) {
        throw InvalidResponseException(
            message: 'Registration failed: Invalid response format');
      }

      final registerResponse = RegisterResponse.fromJson(jsonResponse);

      if (registerResponse.success) {
        return registerResponse;
      } else {
        String userFriendlyMessage = registerResponse.message;

        if (registerResponse.errors != null) {
          if (registerResponse.errors!.username.isNotEmpty) {
            userFriendlyMessage = registerResponse.errors!.username.first;
          } else if (registerResponse.errors!.email.isNotEmpty) {
            userFriendlyMessage = registerResponse.errors!.email.first;
          } else if (registerResponse.errors!.name.isNotEmpty) {
            userFriendlyMessage = registerResponse.errors!.name.first;
          } else if (registerResponse.errors!.gender.isNotEmpty) {
            userFriendlyMessage = registerResponse.errors!.gender.first;
          } else if (registerResponse.errors!.age.isNotEmpty) {
            userFriendlyMessage = registerResponse.errors!.age.first;
          } else if (registerResponse.errors!.password.isNotEmpty) {
            userFriendlyMessage = registerResponse.errors!.password.first;
          }
        }

        throw ServerException(
          message: userFriendlyMessage,
          statusCode: registerResponse.code,
        );
      }
    } on http.ClientException {
      throw NetworkException(message: 'Connection failed: Check your internet');
    } on FormatException {
      throw InvalidResponseException(message: 'Invalid response from server');
    } on ServerException {
      rethrow;
    } catch (e) {
      if (e is ServerException) {
        throw GenericException(message: e.message);
      }
      throw GenericException(
          message: 'Unexpected error during registration: $e');
    }
  }

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.body.isEmpty) {
        throw InvalidResponseException(
            message: 'Login failed: No response from server');
      }

      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse is! Map<String, dynamic>) {
        throw InvalidResponseException(
            message: 'Login failed: Invalid response format');
      }

      final loginResponse = LoginResponse.fromJson(jsonResponse);

      if (loginResponse.success) {
        return loginResponse;
      } else {
        // لو الـ errors فيها تفاصيل، نستخدمها
        String userFriendlyMessage = loginResponse.message;
        if (loginResponse.errors != null) {
          if (loginResponse.errors!.email.isNotEmpty) {
            userFriendlyMessage = loginResponse.errors!.email.first;
          } else if (loginResponse.errors!.password.isNotEmpty) {
            userFriendlyMessage = loginResponse.errors!.password.first;
          }
        }

        throw ServerException(
          message: userFriendlyMessage,
          statusCode: loginResponse.code,
        );
      }
    } on http.ClientException {
      throw NetworkException(message: 'Connection failed: Check your internet');
    } on FormatException {
      throw InvalidResponseException(message: 'Invalid response from server');
    } on ServerException {
      rethrow;
    } catch (e) {
      if (e is ServerException) {
        throw GenericException(message: e.message);
      }
      throw GenericException(message: 'Unexpected error during login: $e');
    }
  }

  Future<ForgetPasswordResponse> forgetPassword(
      ForgetPasswordRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/forgot-password'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );
      if (response.body.isEmpty) {
        throw InvalidResponseException(
            message: 'Forgot password failed: No response from server');
      }

      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse is! Map<String, dynamic>) {
        throw InvalidResponseException(
            message: 'Forgot password failed: Invalid response format');
      }

      final forgetPasswordResponse =
          ForgetPasswordResponse.fromJson(jsonResponse);

      if (forgetPasswordResponse.success) {
        return forgetPasswordResponse;
      } else {
        String userFriendlyMessage = forgetPasswordResponse.message;
        if (forgetPasswordResponse.errors != null) {
          if (forgetPasswordResponse.errors!.email.isNotEmpty) {
            userFriendlyMessage = forgetPasswordResponse.errors!.email.first;
          }
        }

        throw ServerException(
          message: userFriendlyMessage,
          statusCode: forgetPasswordResponse.code,
        );
      }
    } on http.ClientException {
      throw NetworkException(message: 'Connection failed: Check your internet');
    } on FormatException {
      throw InvalidResponseException(message: 'Invalid response from server');
    } on ServerException {
      rethrow;
    } on GenericException {
      rethrow;
    } catch (e) {
      if (e is ServerException || e is GenericException) {
        rethrow;
      }
      throw GenericException(
          message: 'Unexpected error during forget password: $e');
    }
  }
  Future<ForgetPasswordResponse> resendCode(
      ForgetPasswordRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/forgot-password'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );
      if (response.body.isEmpty) {
        throw InvalidResponseException(
            message: 'Forgot password failed: No response from server');
      }

      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse is! Map<String, dynamic>) {
        throw InvalidResponseException(
            message: 'Forgot password failed: Invalid response format');
      }

      final forgetPasswordResponse =
          ForgetPasswordResponse.fromJson(jsonResponse);

      if (forgetPasswordResponse.success) {
        return forgetPasswordResponse;
      } else {
        String userFriendlyMessage = forgetPasswordResponse.message;
        if (forgetPasswordResponse.errors != null) {
          if (forgetPasswordResponse.errors!.email.isNotEmpty) {
            userFriendlyMessage = forgetPasswordResponse.errors!.email.first;
          }
        }

        throw ServerException(
          message: userFriendlyMessage,
          statusCode: forgetPasswordResponse.code,
        );
      }
    } on http.ClientException {
      throw NetworkException(message: 'Connection failed: Check your internet');
    } on FormatException {
      throw InvalidResponseException(message: 'Invalid response from server');
    } on ServerException {
      rethrow;
    } on GenericException {
      rethrow;
    } catch (e) {
      if (e is ServerException || e is GenericException) {
        rethrow;
      }
      throw GenericException(
          message: 'Unexpected error during forget password: $e');
    }
  }
  Future<VerifyCodeResponse> verifyCode(VerifyCodeRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/verify-code'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );
      if (response.body.isEmpty) {
        throw InvalidResponseException(
            message: 'Verify code failed: No response from server');
      }

      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse is! Map<String, dynamic>) {
        throw InvalidResponseException(
            message: 'Verify code failed: Invalid response format');
      }

      final verifyCodeResponse = VerifyCodeResponse.fromJson(jsonResponse);
      if (verifyCodeResponse.success) {
        return verifyCodeResponse;
      } else {
        String userFriendlyMessage = verifyCodeResponse.message;
        if (verifyCodeResponse.errors != null) {
          if (verifyCodeResponse.errors!.code.isNotEmpty) {
            userFriendlyMessage = verifyCodeResponse.errors!.code.first;
          }
        }

        throw ServerException(
          message: userFriendlyMessage,
          statusCode: verifyCodeResponse.code,
        );
      }
    } on http.ClientException {
      throw NetworkException(message: 'Connection failed: Check your internet');
    } on FormatException {
      throw InvalidResponseException(message: 'Invalid response from server');
    } on ServerException {
      rethrow;
    } on GenericException {
      rethrow;
    } catch (e) {
      if (e is ServerException || e is GenericException) {
        rethrow;
      }
      throw GenericException(message: 'Unexpected error during verify code: $e');
    }
  }
  Future<ConfirmationResponse> passwordConfirmation(ConfirmationRequest request) async {
    try{
      
      final response = await http.post(
        Uri.parse("${_baseUrl}/reset-password"),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );
      if(response.body.isEmpty){
        throw InvalidResponseException(
            message: 'Verify code failed: No response from server');
      }
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse is! Map<String, dynamic>) {
        throw InvalidResponseException(
            message: 'Verify code failed: Invalid response format');
      }
      final confirmPasswordResponse= ConfirmationResponse.fromJson(jsonResponse);
      if(confirmPasswordResponse.success){
        return confirmPasswordResponse;
      }else{
        String userFriendlyMessage = confirmPasswordResponse.message;
        if(confirmPasswordResponse.errors != null){
          if(confirmPasswordResponse.errors!.code.isNotEmpty){
            userFriendlyMessage = confirmPasswordResponse.errors!.code.first;

          }

        }
        throw ServerException(
          message: userFriendlyMessage,
          statusCode: confirmPasswordResponse.code,
        );

      }

    }on http.ClientException {
      throw NetworkException(message: 'Connection failed: Check your internet');
    } on FormatException {
      throw InvalidResponseException(message: 'Invalid response from server');
    } on ServerException {
      rethrow;
    } on GenericException {
      rethrow;
    } catch (e) {
      if (e is ServerException || e is GenericException) {
        rethrow;
      }
      throw GenericException(message: 'Unexpected error during verify code: $e');
    }

  }
}
