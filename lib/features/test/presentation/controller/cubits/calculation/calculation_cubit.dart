import 'package:bloc/bloc.dart';
import 'package:graduationproject/config/cache/cache_helper.dart';
import 'package:meta/meta.dart';

import '../../../../data/models/calculation_model/calculation_data_response_model.dart';
import '../../../../data/models/calculation_model/calculation_request_model.dart';
import '../../../../domain/entities/submit/calculation_data_entity.dart';
import '../../../../domain/repo/repo.dart';

part 'calculation_state.dart';

class CalculationCubit extends Cubit<CalculationState> {
  CalculationCubit({required this.testRepo}) : super(CalculationInitial());
  final TestRepository testRepo;

  Future<void> calculate(Map<String, int> answers) async {
    final testId = CacheHelper.getInt(key: 'selected_test_id');
    emit(CalculationLoading());
    final result = await testRepo.calculate(
        calculationRequestModel: CalculationRequestModel(answers: answers),
        testId: testId!);
    result.fold(
      (failure) {
        emit(CalculationError(message: failure.message));
      },
      (response) {
        CacheHelper.set(key: "isTestFinished", value: true);
        emit(CalculationLoaded(calculationDataEntity: response.data!));
      },
    );
  }
}
