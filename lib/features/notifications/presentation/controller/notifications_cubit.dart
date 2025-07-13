import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/notification_entity.dart';
import '../../domain/repo/repo.dart';
part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationRepo notificationRepo;

  NotificationsCubit({required this.notificationRepo}) : super(NotificationsInitial());

  Future<void> getNotifications() async {
    emit(NotificationsLoading());
    final result = await notificationRepo.getNotifications();
    result.fold(
      (failure) => emit(NotificationsError(message: failure.message)),
      (response) => emit(NotificationsLoaded(response: response)),
    );
  }
}