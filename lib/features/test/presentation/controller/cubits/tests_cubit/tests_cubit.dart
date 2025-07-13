import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:graduationproject/config/cache/cache_helper.dart';
import 'package:meta/meta.dart';
import '../../../../data/models/test_response_model/test_names_data_modal.dart';
import '../../../../domain/repo/repo.dart';

part 'tests_state.dart';

class TestsCubit extends Cubit<TestsState> {
  TestsCubit({required this.testRepo}) : super(TestsInitial()) {}
  final TestRepository testRepo;
  List<String> listOfTestsName = [];

  List<dynamic> testsAnswers = [];
  String selected = '';
  List<TestNamesDataModal> listOfTests = [];

  Future<void> getAllTestsName() async {
    emit(TestsLoading());
    final tests = await testRepo.getAllTestsName();
    tests.fold(
      (failure) => emit(TestsError(message: failure.message)),
      (success) {
        emit(TestsSuccess(testData: success));
        listOfTests = success;
        listOfTestsName = success.map((item) => item.name).toList();
        print("From Cubit ${success}");
      },
    );
  }

  TestNamesDataModal getSelectedTestDataObject() {
    for (var item in listOfTests) {
      if (item.name == selected) {
        CacheHelper.set(key: 'selected_test_id', value: item.id);
        CacheHelper.set(key: 'selected_test_name', value: item.name);
        return item;
      }
    }
    CacheHelper.set(key: 'selected_test_id', value: 1);
    return TestNamesDataModal(id: 1, name: "");
  }
}
