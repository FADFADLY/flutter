import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/remote/habit_services.dart';
import '../../domain/entity/habit_response_entity.dart';
import '../../domain/entity/store_habits_response_entity.dart';
import '../../domain/repo/repo.dart';

class HabitRepoImpl extends HabitRepo {
  final HabitService habitService;
  HabitRepoImpl({required this.habitService});
  @override
  Future<Either<Failure, HabitResponseEntity>> getHabits() async {
    try {
      final response = await habitService.getAllHabits();
      if (response.success) {
        return Right(response);
      } else {
        return Left(ServerFailure(
            message: response.message, statusCode: response.code));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in getHabits: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(
          message: "Failed to process habits data: ${e.toString()}"));
    }
  }@override
  Future<Either<Failure, StoreHabitsResponseEntity>> storeHabits(List<int> habits) async {
    try {
      final response = await habitService.storeHabits(habits);
      if (response.success) {
        return Right(response);
      } else {
        return Left(ServerFailure(
          message: response.message,
          statusCode: response.code,
        ));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in storeHabits: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(
        message: "Failed to store habits: ${e.toString()}",
      ));
    }
}}