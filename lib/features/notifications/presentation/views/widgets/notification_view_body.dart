import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../../../core/constants/imports.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../domain/entity/notification_data_entity.dart';
import '../../controller/notifications_cubit.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        if (state is NotificationsLoading) {
          return Center(
            child: SizedBox(
              width: Dimensions.loadingIndicatorSize,
              height: Dimensions.loadingIndicatorSize,
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
                strokeWidth: Dimensions.borderWidth,
                backgroundColor: AppColors.backgroundColor.withOpacity(0.3),
              ),
            ),
          );
        } else if (state is NotificationsLoaded) {
          final notifications = state.response.data;
          if (notifications.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingXXLarge),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.notifications_none,
                      size: Dimensions.iconSizeLarge,
                      color: AppColors.secondaryColor,
                    ),
                    SizedBox(height: Dimensions.boxHeight10),
                    AutoSizeText(
                      S.of(context).noNotifications,
                      style: AppStyles.text18SemiBold.copyWith(color: Colors.grey[700]),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () => context.read<NotificationsCubit>().getNotifications(),
            color: AppColors.primaryColor,
            backgroundColor: AppColors.backgroundColor,
            displacement: Dimensions.boxHeight30,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.paddingMedium,
                horizontal: Dimensions.paddingLarge,
              ),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return NotificationItem(notification: notification);
              },
            ),
          );
        } else if (state is NotificationsError) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingXXLarge),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: Dimensions.iconSizeLarge,
                    color: Colors.red[700],
                  ),
                  SizedBox(height: Dimensions.boxHeight10),
                  AutoSizeText(
                    S.of(context).error,
                    style: AppStyles.text18Bold.copyWith(color: Colors.red[700]),
                    maxLines: 1,
                  ),
                  SizedBox(height: Dimensions.boxHeight8),
                  AutoSizeText(
                    state.message,
                    style: AppStyles.text14Caption,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: Dimensions.boxHeight20),
                  ElevatedButton(
                    style: AppStyles.buttonStyle.copyWith(
                      minimumSize: WidgetStateProperty.all(
                        Size(Dimensions.buttonWidth30Percent, Dimensions.buttonHeight50),
                      ),
                      backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium),
                        ),
                      ),
                      elevation: WidgetStateProperty.all(3),
                    ),
                    onPressed: () => context.read<NotificationsCubit>().getNotifications(),
                    child: AutoSizeText(
                      S.of(context).retry,
                      style: AppStyles.text18Button,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Center(
          child: ElevatedButton(
            style: AppStyles.buttonStyle.copyWith(
              minimumSize: WidgetStateProperty.all(
                Size(Dimensions.buttonWidth30Percent, Dimensions.buttonHeight50),
              ),
              backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium),
                ),
              ),
              elevation: WidgetStateProperty.all(3),
            ),
            onPressed: () => context.read<NotificationsCubit>().getNotifications(),
            child: AutoSizeText(
              S.of(context).loadNotifications,
              style: AppStyles.text18Button,
              maxLines: 1,
            ),
          ),
        );
      },
    );
  }
}

class NotificationItem extends StatelessWidget {
  final NotificationDataEntity notification;

  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // يمكن إضافة منطق لتحديث حالة القراءة أو الانتقال إلى المنشور
        // context.read<NotificationsCubit>().markAsRead(notification.id);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.symmetric(vertical: Dimensions.paddingSmall),
        padding: EdgeInsets.all(Dimensions.paddingMedium),
        decoration: BoxDecoration(
          color: notification.isRead ? Colors.white : AppColors.secondaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusMediumLarge),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: Dimensions.borderRadiusSmall,
              offset: Offset(0, Dimensions.boxHeight2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar with dynamic border
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: notification.isRead ? Colors.grey[300]! : AppColors.primaryColor,
                  width: Dimensions.borderWidth,
                ),
              ),
              child: CircleAvatar(
                radius: Dimensions.avatarUserRadius,
                backgroundColor: AppColors.backgroundColor,
                backgroundImage: notification.sender.image != null
                    ? NetworkImage(notification.sender.image!)
                    : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
              ),
            ),
            SizedBox(width: Dimensions.boxWidth12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    notification.sender.username,
                    style: AppStyles.text16Bold.copyWith(color: AppColors.primaryColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: Dimensions.boxHeight4),
                  AutoSizeText(
                    notification.message,
                    style: AppStyles.text14Regular.copyWith(color: Colors.black87),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: Dimensions.boxHeight6),
                  AutoSizeText(
                    notification.createdAt,
                    style: AppStyles.text12Caption.copyWith(color: Colors.grey[600]),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            // Unread Indicator
            if (!notification.isRead)
              Padding(
                padding: EdgeInsets.only(right: Dimensions.paddingSmall),
                child: Container(
                  width: Dimensions.dotSize,
                  height: Dimensions.dotSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryColor.withOpacity(0.4),
                        blurRadius: Dimensions.borderRadiusExtraSmall,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}