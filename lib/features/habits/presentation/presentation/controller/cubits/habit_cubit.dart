import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../domain/entity/habit_data_entity.dart';
import '../../../../domain/entity/habit_response_entity.dart';
import '../../../../domain/repo/repo.dart';

part 'habit_state.dart';

class HabitCubit extends Cubit<HabitState> {
  final HabitRepo habitRepo;

  HabitCubit({required this.habitRepo}) : super(HabitInitial());

  Future<void> getHabits() async {
    emit(HabitLoading());

    final habits = await habitRepo.getHabits();
    habits.fold(
          (failure) => emit(HabitError(message: failure.message)),
          (response) {
            print(response.data);
            emit(HabitLoaded(habits: response.data));
          },
    );
  }
}