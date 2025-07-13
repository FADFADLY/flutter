import 'package:dartz/dartz.dart';
import 'package:graduationproject/core/constants/imports.dart';

import '../../data/models/forget_password/code_request.dart';
import '../../data/models/forget_password/confirmation_request.dart';
import '../../data/models/forget_password/email_request.dart';
import '../entities/logout_response_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, bool>> register({
    required RegisterRequest registerRequest,
  });

  Future<Either<Failure, LoginUserEntity>> login({
    required LoginRequest loginRequest,
  });
  Future<Either<Failure, LogoutResponseEntity>> logout();

  Future<Either<Failure, bool>> forgetPassword(
      {required ForgetPasswordRequest forgetPasswordRequest});
  Future<Either<Failure, bool>> resendCode(
      {required ForgetPasswordRequest forgetPasswordRequest});

  Future<Either<Failure, bool>> verifyCode(
      {required VerifyCodeRequest verifyCodeRequest});
  Future<Either<Failure, bool>> confirmPassword({required ConfirmationRequest confirmationRequest});

}
