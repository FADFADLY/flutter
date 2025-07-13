import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/services/remote/notification_service.dart';
import '../../domain/entity/notification_entity.dart';
import '../../domain/repo/repo.dart';

class NotificationRepoImpl extends NotificationRepo {
  final NotificationService notificationService;

  NotificationRepoImpl({required this.notificationService});

  @override
  Future<Either<Failure, NotificationEntity>> getNotifications() async {
    try {
      if (notificationService == null) {
        throw GenericException(message: 'NotificationService is not initialized');
      }

      final response = await notificationService.getNotifications();
      if (response.success) {
        return Right(response);
      } else {
        return Left(ServerFailure(message: response.message, statusCode: response.code));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in getNotifications: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(message: "Failed to fetch notifications: ${e.toString()}"));
    }
  }
}