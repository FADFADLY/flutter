import 'package:dartz/dartz.dart';

import 'package:graduationproject/core/errors/failure.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/services/remote/tests_service.dart';
import '../../domain/repo/repo.dart';
import '../models/calculation_model/calculation_request_model.dart';
import '../models/calculation_model/calculation_response_model.dart';
import '../models/question_response_model/question_modal.dart';
import '../models/question_response_model/question_test_modal.dart';
import '../models/test_response_model/test_names_data_modal.dart';

class TestRepositoryImplementation extends TestRepository {
  final TestsService testsService;

  TestRepositoryImplementation({required this.testsService});

  @override
  Future<Either<Failure, List<TestNamesDataModal>>> getAllTestsName() async {
    try {
      final response = await testsService.getAllTestsName();
      final tests = response.data!;
      if (response.success!) {
        return Right(tests);
      } else {
        return Left(ServerFailure(
            message: response.message!, statusCode: response.code));
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
  Future<Either<Failure, QuestionsTestModel>> getAllQuestions(int id) async {
    try {
      final response = await testsService.getAllQuestions(id);
      if (response.success) {
        return Right(response.data!);
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
    } catch (e, stackTrace) {
      print('Error: $e');
      print('Stack Trace: $stackTrace');
      return Left(GenericFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, CalculationResponseModel>> calculate(
      {required testId, required CalculationRequestModel calculationRequestModel}) async {
    try {
      final response = await testsService.calculate(
        testId: testId,
        calculationRequestModel: calculationRequestModel,

      );
      if (response.success) {
        return Right(response);
      } else {
        return Left(ServerFailure(
            message: response.message, statusCode: response.code));
      }

    }on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e) {
      return Left(GenericFailure(message: e.toString()));
    }
  }

}
