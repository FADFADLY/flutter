import 'package:dartz/dartz.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/features/auth/data/models/forget_password/code_request.dart';
import 'package:http/http.dart';
import '../../../../core/constants/sensitive_strings.dart';
import '../../../../core/constants/strings.dart';

import '../../../../config/cache/secure_cache_helper.dart';
import '../../domain/entities/logout_response_entity.dart';
import '../models/forget_password/confirmation_request.dart';
import '../models/forget_password/email_request.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthService authService;

  AuthRepoImpl({required this.authService});

  @override
  Future<Either<Failure, bool>> register(
      {required RegisterRequest registerRequest}) async {
    try {
      final response = await authService.register(registerRequest);
      if (response.success) {
        return Right(true);
      } else {
        return Left(ServerFailure(
            message: response.message, statusCode: response.code));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e) {
      return Left(GenericFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, LoginUserEntity>> login(
      {required LoginRequest loginRequest}) async {
    try {
      final response = await authService.login(loginRequest);
      if (response.success) {
        final token = response.data!.token;
        await SecureCacheHelper.set(key: SensitiveStrings.accessToken, value: token);
        return Right(LoginUserEntity(token: token));
      } else {
        return Left(ServerFailure(
            message: response.message, statusCode: response.code));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e) {
      return Left(GenericFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> forgetPassword(
      {required ForgetPasswordRequest forgetPasswordRequest}) async {
    try {
      final response =
      await authService.forgetPassword(forgetPasswordRequest);
      if (response.success) {
        return Right(true);
      } else {
        return Left(ServerFailure(
            message: response.message, statusCode: response.code));
      }
    } on ServerException catch (e) {
      return Left(
          ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e) {
      return Left(GenericFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> resendCode(
      {required ForgetPasswordRequest forgetPasswordRequest}) async {
    try {
      final response =
      await authService.forgetPassword(forgetPasswordRequest);
      if (response.success) {
        return Right(true);
      } else {
        return Left(ServerFailure(
            message: response.message, statusCode: response.code));
      }
    } on ServerException catch (e) {
      return Left(
          ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e) {
      return Left(GenericFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyCode(
      {required VerifyCodeRequest verifyCodeRequest}) async {
    try {
      final response = await authService.verifyCode(verifyCodeRequest);

      if (response.success) {
        return Right(true);
      } else {
        return Left(ServerFailure(
            message: response.message, statusCode: response.code));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e) {
      return Left(GenericFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> confirmPassword(
      {required ConfirmationRequest confirmationRequest}) async {
    try {
      final response = await authService.passwordConfirmation(confirmationRequest);

      if (response.success) {
        return Right(true);
      } else {
        return Left(ServerFailure(
            message: response.message, statusCode: response.code));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e) {
      return Left(GenericFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, LogoutResponseEntity>> logout() async {
    try {
      final response = await authService.logout();
      await SecureCacheHelper.remove(key: SensitiveStrings.accessToken);
      await SecureCacheHelper.remove(key: "user_name");

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(SensitiveStrings.isOnBoardingViewSeen);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e, stackTrace) {
      print("Error in logout: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(message: "Failed to logout: ${e.toString()}"));
    }
  }}