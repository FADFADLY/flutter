import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/imports.dart';

import '../../domain/repo/repo.dart';
import '../controller/notifications_cubit.dart';
import 'widgets/notification_view_body.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationsCubit(
        notificationRepo: getIt<NotificationRepo>(),
      )..getNotifications(), // Call getNotifications when the widget is created
      child: Scaffold(
        appBar: buildAppBar(
          context,
          title: S.of(context).notifications,
          showBackButton: false,
          backgroundColor: AppColors.secondaryColor,
        ),
        body: const NotificationViewBody(),
      ),
    );
  }
}