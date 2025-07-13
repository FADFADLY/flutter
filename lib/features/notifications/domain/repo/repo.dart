import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entity/notification_entity.dart';

abstract class NotificationRepo {
  Future<Either<Failure, NotificationEntity>> getNotifications();
}