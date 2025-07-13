part of 'tests_cubit.dart';

@immutable
sealed class TestsState {}
final class TestsInitial extends TestsState {}
final class TestsLoading extends TestsState {}
final class TestsSuccess extends TestsState {
  final List<TestNamesDataModal> testData;

  TestsSuccess({required this.testData});
}
final class TestsError extends TestsState {
  final String message;

  TestsError({required this.message});
}

