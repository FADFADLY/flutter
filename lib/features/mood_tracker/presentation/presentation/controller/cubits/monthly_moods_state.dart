part of 'monthly_moods_cubit.dart';

abstract class MonthlyMoodsState {
  const MonthlyMoodsState();
}

class MonthlyMoodsInitial extends MonthlyMoodsState {}

class MonthlyMoodsLoading extends MonthlyMoodsState {}

class MonthlyMoodsLoaded extends MonthlyMoodsState {
  final MonthlyMoodsResponseEntity response;

  const MonthlyMoodsLoaded({required this.response});
}

class MonthlyMoodsError extends MonthlyMoodsState {
  final String message;

  const MonthlyMoodsError({required this.message});
}