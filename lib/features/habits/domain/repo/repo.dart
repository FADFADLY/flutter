import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entity/habit_response_entity.dart';
import '../entity/store_habits_response_entity.dart';

abstract class HabitRepo {
  Future<Either<Failure, HabitResponseEntity>> getHabits();
  Future<Either<Failure, StoreHabitsResponseEntity>> storeHabits(List<int> habits);
}
