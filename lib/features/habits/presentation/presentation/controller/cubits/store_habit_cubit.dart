import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../domain/entity/store_habits_response_entity.dart';
import '../../../../domain/repo/repo.dart';

part 'store_habit_state.dart';

class StoreHabitCubit extends Cubit<StoreHabitState> {
  final HabitRepo habitRepo;

  StoreHabitCubit({required this.habitRepo}) : super(StoreHabitInitial());

  Future<void> storeHabits(List<int> habits) async {
    emit(StoreHabitLoading());

    final result = await habitRepo.storeHabits(habits);
    result.fold(
          (failure) => emit(StoreHabitError(message: failure.message)),
          (response) => emit(StoreHabitSuccess(response: response)),
    );
  }
}
