part of 'calculation_cubit.dart';

@immutable
sealed class CalculationState {}

final class CalculationInitial extends CalculationState {}

final class CalculationLoading extends CalculationState {}

final class CalculationLoaded extends CalculationState {
  final CalculationDataEntity calculationDataEntity;
  CalculationLoaded({required this.calculationDataEntity});
}
final class CalculationError extends CalculationState {
  final String message;
  CalculationError({required this.message});
}