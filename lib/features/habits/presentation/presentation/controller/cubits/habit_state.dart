part of 'habit_cubit.dart';

@immutable
sealed class HabitState {}

final class HabitInitial extends HabitState {}

final class HabitLoading extends HabitState {}

final class HabitLoaded extends HabitState {
  final List<HabitDataEntity> habits;

  HabitLoaded({required this.habits});
}

final class HabitError extends HabitState {
  final String message;

  HabitError({required this.message});
}