part of 'store_habit_cubit.dart';

@immutable
sealed class StoreHabitState {}

final class StoreHabitInitial extends StoreHabitState {}

final class StoreHabitLoading extends StoreHabitState {}

final class StoreHabitSuccess extends StoreHabitState {
  final StoreHabitsResponseEntity response;

  StoreHabitSuccess({required this.response});
}

final class StoreHabitError extends StoreHabitState {
  final String message;

  StoreHabitError({required this.message});
}