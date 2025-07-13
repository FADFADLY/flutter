import 'package:dartz/dartz.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/features/test/data/models/calculation_model/calculation_response_model.dart';
import '../../data/models/calculation_model/calculation_request_model.dart';
import '../../data/models/question_response_model/question_modal.dart';
import '../../data/models/question_response_model/question_test_modal.dart';
import '../../data/models/test_response_model/test_names_data_modal.dart';
import '../../data/models/test_response_model/test_names_modal.dart';
import '../entities/question/test_info_entity.dart';
import '../entities/tests/test_entity.dart';

abstract class TestRepository {
  Future<Either<Failure, List<TestNamesDataModal>>> getAllTestsName();

  Future<Either<Failure, TestInfoEntity>> getAllQuestions(int id);

  Future<Either<Failure, CalculationResponseModel>> calculate(
      {required testId, required CalculationRequestModel calculationRequestModel});
}
