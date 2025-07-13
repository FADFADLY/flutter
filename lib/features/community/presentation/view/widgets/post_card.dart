import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject/features/community/presentation/view/widgets/post_content.dart';
import 'package:graduationproject/features/community/presentation/view/widgets/post_edit_field.dart';
import 'package:graduationproject/features/community/presentation/view/widgets/post_interaction_buttons.dart';
import 'package:like_button/like_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../../../core/constants/imports.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/styles.dart';
import '../../../domain/entity/posts_data_entity.dart';
import '../../controller/cubits/delete_post_cubit.dart';
import '../../controller/cubits/get_posts_cubit.dart';
import '../../controller/cubits/update_post_cubit.dart';
import '../../controller/cubits/reaction_cubit.dart';
import '../../controller/cubits/vote_cubit.dart';
import '../../controller/cubits/store_comment_cubit.dart';
import '../../controller/cubits/get_comments_cubit.dart';
import 'attachment_display.dart';
import 'comment_section.dart';
import 'post_actions.dart';

class PostCard extends StatelessWidget {
  final PostDataEntity post;
  final bool isExpanded;
  final int? activeCommentPostId;
  final int? editingCommentId;
  final int? editingPostId;
  final TextEditingController commentController;
  final TextEditingController editCommentController;
  final TextEditingController editPostController;
  final String? currentUserName;
  final bool isLoadingUserName;
  final bool Function(String, TextStyle, double) doesTextExceedTwoLines;
  final VoidCallback onToggleExpand;
  final void Function(int?) onToggleCommentPost;
  final void Function(int?, String?) onToggleEditComment;
  final void Function(int?, String?) onToggleEditPost;

  const PostCard({
    super.key,
    required this.post,
    required this.isExpanded,
    required this.activeCommentPostId,
    required this.editingCommentId,
    required this.editingPostId,
    required this.commentController,
    required this.editCommentController,
    required this.editPostController,
    required this.currentUserName,
    required this.isLoadingUserName,
    required this.doesTextExceedTwoLines,
    required this.onToggleExpand,
    required this.onToggleCommentPost,
    required this.onToggleEditComment,
    required this.onToggleEditPost,
  });

  @override
  Widget build(BuildContext context) {
    final isCurrentUserPost = currentUserName != null &&
        currentUserName!.toLowerCase().trim() ==
            post.userName.toLowerCase().trim();
    final maxWidth = MediaQuery.of(context).size.width - Dimensions.boxWidth64;
    final exceedsTwoLines =
    doesTextExceedTwoLines(post.content, AppStyles.text14Regular, maxWidth);

    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.boxHeight8),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingMedium,
          vertical: Dimensions.paddingMedium,
        ),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusMediumLarge),
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
                  radius: Dimensions.avatarUserRadius,
                  backgroundColor: AppColors.secondaryColor,
                  child: Icon(Icons.person, color: AppColors.whiteColor),
                ),
                SizedBox(width: Dimensions.boxWidth10),
                Column(
                  mainAxisSize:  MainAxisSize.min ,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Dimensions.boxHeight30,
                      child: AutoSizeText(
                        post.userName,
                        style: AppStyles.text16SemiBold,
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                    AutoSizeText(
                      post.createdAt,
                      style: AppStyles.text12Regular,
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
                const Spacer(),
                if (isCurrentUserPost && !isLoadingUserName)
                  Row(
                    children: [
                      BlocBuilder<DeletePostCubit, DeletePostState>(
                        builder: (context, state) {
                          return IconButton(
                            icon: Icon(
                              Icons.delete_outline,
                              color: AppColors.secondaryColor,
                            ),
                            onPressed: () async {
                              await context
                                  .read<DeletePostCubit>()
                                  .deletePost(postId: post.id);
                              await context.read<GetPostsCubit>().getPosts();
                            },
                          );
                        },
                      ),
                      BlocBuilder<UpdatePostCubit, UpdatePostState>(
                        builder: (context, state) {
                          bool isUpdating =
                              state is UpdatePostLoading && state.postId == post.id;
                          return IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: AppColors.secondaryColor,
                            ),
                            onPressed: isUpdating
                                ? null
                                : () {
                              onToggleEditPost(
                                  editingPostId == post.id ? null : post.id,
                                  editingPostId == post.id
                                      ? null
                                      : post.content);
                            },
                          );
                        },
                      ),
                    ],
                  ),
              ],
            ),
            SizedBox(height: Dimensions.boxHeight12),
            editingPostId == post.id
                ? PostEditField(
              editPostController: editPostController,
              postId: post.id,
              onCancel: () => onToggleEditPost(null, null),
            )
                : PostContent(
              content: post.content,
              isExpanded: isExpanded,
              exceedsTwoLines: exceedsTwoLines,
              onToggleExpand: onToggleExpand,
            ),
            SizedBox(height: Dimensions.boxHeight12),
            AttachmentDisplay(post: post),
            SizedBox(height: Dimensions.boxHeight12),
            PostActions(
              post: post,
              activeCommentPostId: activeCommentPostId,
              onToggleCommentPost: onToggleCommentPost,
            ),
            Divider(
              height: Dimensions.boxHeight24,
              thickness: Dimensions.borderWidth,
              color: AppColors.greyLightColor,
            ),
            PostInteractionButtons(
              post: post,
              activeCommentPostId: activeCommentPostId,
              onToggleCommentPost: onToggleCommentPost,
            ),
            if (activeCommentPostId == post.id)
              CommentSection(
                postId: post.id,
                commentController: commentController,
                editCommentController: editCommentController,
                editingCommentId: editingCommentId,
                currentUserName: currentUserName,
                isLoadingUserName: isLoadingUserName,
                onToggleEditComment: onToggleEditComment,
              ),
          ],
        ),
      ),
    );
  }
}