import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/constants/imports.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../generated/assets.dart';
import '../../../../blog/presentation/view/widgets/refresh_pump_heart_with_child.dart';
import '../../../../community/domain/entity/attachment_entity.dart';
import '../../../../community/domain/repo/repo.dart';
import '../../controller/cubit/liked_posts_cubit.dart';
import '../../../../home/presentation/views/NavBar.dart';

class MyPosts extends StatelessWidget {
  const MyPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LikedPostsCubit(
        postsRepo: getIt<PostsRepo>(),
      )..getPosts(),
      child: Scaffold(
        appBar: buildAppBar(
          context,
          title: S.of(context).liked_posts,
          navigateTo: BottomNavBar.routeName,
          backgroundColor: AppColors.secondaryColor,
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingMedium),
                child: CustomRefreshIndicator(
                  onRefresh: () async =>
                      context.read<LikedPostsCubit>().getPosts(),
                  builder: (context, child, controller) => RefreshPumpHeartWithChild(
                    showPumpHeart: controller.value > 0,
                    offset: controller.value * Dimensions.boxHeight50,
                    controller: controller,
                    child: child,
                  ),
                  child: BlocBuilder<LikedPostsCubit, LikedPostsState>(
                    builder: (context, state) {
                      if (state is GetLikedPostsLoading) {
                        return Skeletonizer(
                          enabled: true,
                          child: ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.only(bottom: Dimensions.boxHeight8),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingMedium,
                                  vertical: Dimensions.paddingMedium,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.borderRadiusMediumLarge),
                                  border: Border.all(color: AppColors.greyLightColor),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.greyLightColor.withOpacity(0.1),
                                      blurRadius: Dimensions.boxHeight4,
                                      offset: Offset(0, Dimensions.boxHeight2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const CircleAvatar(radius: 22),
                                        SizedBox(width: Dimensions.boxHeight10),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: Dimensions.boxHeight100,
                                              height: Dimensions.boxHeight10,
                                              color: AppColors.greyLightColor,
                                            ),
                                            SizedBox(height: Dimensions.boxHeight4),
                                            Container(
                                              width: Dimensions.boxHeight60,
                                              height: Dimensions.boxHeight8,
                                              color: AppColors.greyLightColor,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: Dimensions.boxHeight12),
                                    Container(
                                      height: Dimensions.boxHeight10,
                                      width: double.infinity,
                                      color: AppColors.greyLightColor,
                                    ),
                                    SizedBox(height: Dimensions.boxHeight6),
                                    Container(
                                      height: Dimensions.boxHeight10,
                                      width: MediaQuery.of(context).size.width * 0.7,
                                      color: AppColors.greyLightColor,
                                    ),
                                    SizedBox(height: Dimensions.boxHeight12),
                                    Container(
                                      height: Dimensions.boxHeight180,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppColors.greyLightColor,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.borderRadiusSmall),
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.boxHeight12),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.thumb_up_alt_outlined,
                                          size: Dimensions.iconSize,
                                          color: AppColors.greyLightColor,
                                        ),
                                        SizedBox(width: Dimensions.boxHeight8),
                                        Container(
                                          width: Dimensions.boxHeight20,
                                          height: Dimensions.boxHeight8,
                                          color: AppColors.greyLightColor,
                                        ),
                                        SizedBox(width: Dimensions.boxHeight16),
                                        Icon(
                                          Icons.comment,
                                          size: Dimensions.iconSize,
                                          color: AppColors.greyLightColor,
                                        ),
                                        SizedBox(width: Dimensions.boxHeight8),
                                        Container(
                                          width: Dimensions.boxHeight20,
                                          height: Dimensions.boxHeight8,
                                          color: AppColors.greyLightColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      } else if (state is GetLikedPostsLoaded) {
                        return ListView.builder(
                          itemCount: state.posts.length,
                          itemBuilder: (context, index) {
                            final post = state.posts[index];
                            String? attachmentUrl;
                            String? attachmentType;

                            if (post.attachment is String) {
                              attachmentUrl = post.attachment as String;
                              attachmentType = post.type;
                            } else if (post.attachment is AttachmentEntity) {
                              final attachment = post.attachment as AttachmentEntity;
                              attachmentUrl = attachment.image ?? attachment.title;
                              attachmentType = post.type;
                            }

                            return Padding(
                              padding: EdgeInsets.only(bottom: Dimensions.boxHeight8),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingMedium,
                                  vertical: Dimensions.paddingMedium,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.borderRadiusMediumLarge),
                                  border: Border.all(color: AppColors.greyLightColor),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.greyLightColor.withOpacity(0.1),
                                      blurRadius: Dimensions.boxHeight4,
                                      offset: Offset(0, Dimensions.boxHeight2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 22,
                                          backgroundColor: AppColors.secondaryColor,
                                          child: Icon(Icons.person,
                                              color: AppColors.whiteColor),
                                        ),
                                        SizedBox(width: Dimensions.boxHeight10),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              post.userName,
                                              style: AppStyles.text14SemiBold,
                                              textDirection: TextDirection.rtl,
                                            ),
                                            Text(
                                              post.createdAt,
                                              style: AppStyles.text12Regular
                                                  .copyWith(
                                                fontSize: Dimensions.fontSize10,
                                                color: AppColors.greyColor,
                                              ),
                                              textDirection: TextDirection.rtl,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: Dimensions.boxHeight12),
                                    Text(
                                      post.content,
                                      style: AppStyles.text14Regular,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textDirection: TextDirection.rtl,
                                    ),
                                    SizedBox(height: Dimensions.boxHeight12),
                                    if (attachmentUrl != null)
                                      if (attachmentType == 'image')
                                        GestureDetector(
                                          onTap: () =>
                                              showImagePopup(context, attachmentUrl!),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.borderRadiusSmall),
                                            child: Image.network(
                                              attachmentUrl,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      else if (attachmentType == 'file')
                                        GestureDetector(
                                          onTap: () {
                                            if (attachmentUrl!.isNotEmpty &&
                                                Uri.parse(attachmentUrl)
                                                    .isAbsolute) {
                                              showPdfPopup(context, attachmentUrl);
                                            }
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: Dimensions.boxHeight10),
                                            child: Container(
                                              padding: EdgeInsets.all(
                                                  Dimensions.paddingSmall),
                                              decoration: BoxDecoration(
                                                color: AppColors.greyLightColor,
                                                borderRadius: BorderRadius.circular(
                                                    Dimensions.borderRadiusSmall),
                                                border: Border.all(
                                                    color: AppColors.secondaryColor),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.insert_drive_file,
                                                    color: AppColors.secondaryColor,
                                                    size: Dimensions.socialIconSize,
                                                  ),
                                                  SizedBox(
                                                      width: Dimensions.boxHeight8),
                                                  Text(
                                                    S.of(context).file,
                                                    style: AppStyles.text14Regular
                                                        .copyWith(
                                                      color: AppColors.secondaryColor,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                    textDirection:
                                                    TextDirection.rtl,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      else if (attachmentType == 'poll' &&
                                            post.attachment is AttachmentEntity &&
                                            (post.attachment as AttachmentEntity)
                                                .options !=
                                                null)
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: (post.attachment
                                            as AttachmentEntity)
                                                .options!
                                                .where((option) => option != null)
                                                .map<Widget>((option) {
                                              final percentage =
                                                  option.percentage ?? 0.0;
                                              final progressValue =
                                              (percentage / 100).clamp(0.0, 1.0);
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    top: Dimensions.boxHeight8),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: Dimensions.boxHeight10,
                                                    horizontal:
                                                    Dimensions.paddingMedium,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        AppColors.greyLightColor
                                                            .withOpacity(0.1),
                                                        Colors.transparent,
                                                      ],
                                                      stops: [
                                                        progressValue,
                                                        progressValue
                                                      ],
                                                      begin: Alignment.centerRight,
                                                      end: Alignment.centerLeft,
                                                    ),
                                                    borderRadius: BorderRadius.circular(
                                                        Dimensions
                                                            .borderRadiusMediumLarge),
                                                    border: Border.all(
                                                      color: AppColors.greyLightColor,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        option.option,
                                                        style: AppStyles.text14Regular
                                                            .copyWith(
                                                          color: AppColors.greyColor,
                                                          fontWeight: option.voted
                                                              ? FontWeight.bold
                                                              : FontWeight.normal,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: Dimensions.boxHeight8),
                                                      Text(
                                                        '${option.percentage}%',
                                                        style: AppStyles.text12Regular
                                                            .copyWith(
                                                          color: AppColors.greyColor,
                                                          fontWeight: option.voted
                                                              ? FontWeight.bold
                                                              : FontWeight.normal,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                    if (attachmentUrl != null ||
                                        attachmentType == 'poll')
                                      SizedBox(height: Dimensions.boxHeight12),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.thumb_up_alt_outlined,
                                          size: Dimensions.iconSize,
                                          color: AppColors.secondaryColor,
                                        ),
                                        SizedBox(width: Dimensions.boxHeight5),
                                        Text(
                                          post.reactionsCount.toString(),
                                          style: AppStyles.text14Regular.copyWith(
                                            color: AppColors.secondaryColor,
                                          ),
                                          textDirection: TextDirection.rtl,
                                        ),
                                        SizedBox(width: Dimensions.boxHeight16),
                                        Icon(
                                          Icons.comment,
                                          size: Dimensions.iconSize,
                                          color: AppColors.secondaryColor,
                                        ),
                                        SizedBox(width: Dimensions.boxHeight5),
                                        Text(
                                          post.commentsCount.toString(),
                                          style: AppStyles.text14Regular.copyWith(
                                            color: AppColors.secondaryColor,
                                          ),
                                          textDirection: TextDirection.rtl,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else if (state is GetLikedPostsError) {
                        return Center(
                          child: Text(
                            state.message,
                            style: AppStyles.text16Regular,
                            textDirection: TextDirection.rtl,
                          ),
                        );
                      }
                      return Center(
                        child: Text(
                          S.of(context).no_data,
                          style: AppStyles.text16Regular,
                          textDirection: TextDirection.rtl,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showImagePopup(BuildContext context, String imagePath) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: S.of(context).image_preview,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Scaffold(
          backgroundColor: AppColors.blackColor.withOpacity(0.95),
          body: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Center(
              child: Hero(
                tag: imagePath,
                child: InteractiveViewer(
                  panEnabled: true,
                  scaleEnabled: true,
                  minScale: 1,
                  maxScale: 5,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Image.network(imagePath, fit: BoxFit.contain),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }

  void showPdfPopup(BuildContext context, String pdfUrl) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: S.of(context).file_preview,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;
        final frameWidth = screenWidth;
        final frameHeight = screenHeight;

        return WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);
            return true;
          },
          child: Scaffold(
            backgroundColor: AppColors.blackColor.withOpacity(0.7),
            body: Center(
              child: Container(
                width: frameWidth,
                height: frameHeight,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius:
                  BorderRadius.circular(Dimensions.borderRadiusMediumLarge),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blackColor.withOpacity(0.1),
                      blurRadius: Dimensions.boxHeight10,
                      offset: Offset(0, Dimensions.boxHeight5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                        height:
                        MediaQuery.of(context).padding.top + Dimensions.boxHeight10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.close, color: AppColors.errorColor),
                          onPressed: () => Navigator.pop(context),
                        ),
                        SizedBox(width: Dimensions.boxHeight10),
                      ],
                    ),
                    Expanded(
                      child: PDF(
                        swipeHorizontal: false,
                      ).cachedFromUrl(
                        pdfUrl,
                        errorWidget: (dynamic error) =>
                            Center(child: Text(error.toString())),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }
}