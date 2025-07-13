import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:like_button/like_button.dart';
import '../../../../../core/constants/imports.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/styles.dart';
import '../../../domain/entity/comment_entity.dart';
import '../../controller/cubits/comments_reaction_cubit.dart';
import '../../controller/cubits/delete_comment_cubit.dart';
import '../../controller/cubits/update_comment_cubit.dart';
import '../../controller/cubits/get_comments_cubit.dart';

class CommentCard extends StatelessWidget {
  final CommentEntity comment;
  final int postId;
  final int? editingCommentId;
  final TextEditingController editCommentController;
  final String? currentUserName;
  final bool isLoadingUserName;
  final void Function(int?, String?) onToggleEditComment;

  const CommentCard({
    super.key,
    required this.comment,
    required this.postId,
    required this.editingCommentId,
    required this.editCommentController,
    required this.currentUserName,
    required this.isLoadingUserName,
    required this.onToggleEditComment,
  });

  @override
  Widget build(BuildContext context) {
    final isCurrentUserComment = currentUserName != null &&
        currentUserName!.toLowerCase().trim() ==
            comment.user.username.toLowerCase().trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Comment Card
        Padding(
          padding: EdgeInsets.symmetric(vertical: Dimensions.boxHeight6),
          child: Container(
            padding: EdgeInsets.all(Dimensions.paddingMedium),
            decoration: BoxDecoration(
              color: AppColors.greyLightColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium),
              border: Border.all(color: AppColors.backgroundColor, width: Dimensions.borderWidth05),
              boxShadow: [
                BoxShadow(
                  color: AppColors.greyColor.withOpacity(0.05),
                  blurRadius: Dimensions.boxHeight4,
                  offset: Offset(0, Dimensions.boxHeight1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: Dimensions.avatarRadiusSmall,
                      backgroundColor: AppColors.secondaryColor,
                      child: comment.user.image.isNotEmpty
                          ? ClipOval(
                        child: Image.network(
                          comment.user.image,
                          width: Dimensions.boxWidth40,
                          height: Dimensions.boxHeight40,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.person,
                            color: AppColors.whiteColor,
                            size: Dimensions.iconSize,
                          ),
                        ),
                      )
                          : Icon(
                        Icons.person,
                        color: AppColors.whiteColor,
                        size: Dimensions.iconSize,
                      ),
                    ),
                    SizedBox(width: Dimensions.boxWidth10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingMedium,
                              vertical: Dimensions.boxHeight8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.secondaryColor.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  comment.user.username,
                                  style: AppStyles.text16SemiBold,
                                  textDirection: TextDirection.rtl,
                                ),
                                SizedBox(height: Dimensions.boxHeight4),
                                AutoSizeText(
                                  comment.body,
                                  style: AppStyles.text14Regular,
                                  textDirection: TextDirection.rtl,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: Dimensions.boxWidth10),
                    if (isCurrentUserComment && !isLoadingUserName)
                      Row(
                        children: [
                          BlocBuilder<DeleteCommentCubit, DeleteCommentState>(
                            builder: (context, deleteState) {
                              bool isDeleting = deleteState is DeleteCommentLoading &&
                                  deleteState.commentId == comment.id;
                              return IconButton(
                                onPressed: isDeleting
                                    ? null
                                    : () {
                                  context
                                      .read<DeleteCommentCubit>()
                                      .deleteComment(commentId: comment.id);
                                },
                                icon: isDeleting
                                    ? SizedBox(
                                  width: Dimensions.boxWidth20,
                                  height: Dimensions.boxHeight20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: Dimensions.borderWidth,
                                    color: AppColors.secondaryColor,
                                  ),
                                )
                                    : Icon(
                                  Icons.delete_outline,
                                  color: AppColors.secondaryColor,
                                  size: Dimensions.iconSize,
                                ),
                              );
                            },
                          ),
                          IconButton(
                            onPressed: () {
                              onToggleEditComment(
                                  editingCommentId == comment.id ? null : comment.id,
                                  editingCommentId == comment.id ? null : comment.body);
                            },
                            icon: Icon(
                              Icons.edit,
                              color: AppColors.secondaryColor,
                              size: Dimensions.iconSize,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                SizedBox(height: Dimensions.boxHeight6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AutoSizeText(
                      comment.createdAt,
                      style: AppStyles.text12Regular,
                      textDirection: TextDirection.rtl,
                    ),
                    SizedBox(width: Dimensions.boxWidth16),
                    BlocBuilder<CommentsReactionCubit, CommentsReactionState>(
                      builder: (context, reactionState) {
                        bool isLoading = reactionState is CommentsReactionLoading &&
                            reactionState.commentId == comment.id;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LikeButton(
                              onTap: (bool isLiked) async {
                                if (isLoading) return isLiked;
                                context.read<GetCommentsCubit>().updateCommentReaction(
                                  postId: postId,
                                  commentId: comment.id,
                                  reacted: !comment.reacted,
                                  reactionsCount:
                                  comment.reactionsCount + (comment.reacted ? -1 : 1),
                                );
                                await context
                                    .read<CommentsReactionCubit>()
                                    .reaction(commentId: comment.id, type: 'comment');
                                return !comment.reacted;
                              },
                              size: Dimensions.boxHeight25,
                              isLiked: comment.reacted,
                              likeBuilder: (bool isLiked) {
                                return isLoading
                                    ? SizedBox(
                                  width: Dimensions.boxWidth20,
                                  height: Dimensions.boxHeight20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: Dimensions.borderWidth,
                                    color: AppColors.secondaryColor,
                                  ),
                                )
                                    : Icon(
                                  comment.reacted
                                      ? Icons.thumb_up_alt
                                      : Icons.thumb_up_alt_outlined,
                                  color: AppColors.secondaryColor,
                                  size: Dimensions.iconSize,
                                );
                              },
                            ),
                            SizedBox(width: Dimensions.boxWidth4),
                            AutoSizeText(
                              comment.reactionsCount.toString(),
                              style: AppStyles.text12Regular,
                              textDirection: TextDirection.rtl,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Separate TextField for editing
        if (editingCommentId == comment.id)
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingMedium,
              vertical: Dimensions.boxHeight6,
            ),
            child: Container(
              constraints: BoxConstraints(
                minHeight: Dimensions.boxHeight30, // Larger height for TextField
                minWidth: double.infinity, // Full width
              ),
              decoration: BoxDecoration(
                color: AppColors.greyLightColor,
                borderRadius: BorderRadius.circular(Dimensions.borderRadiusXLarge),
                border: Border.all(
                  color: AppColors.secondaryColor.withOpacity(0.5),
                  width: Dimensions.borderWidth,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: editCommentController,
                      style: AppStyles.text16Regular, // Slightly larger text
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        hintText: S.of(context).edit_comment_hint,
                        hintStyle: AppStyles.text16Regular,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingMedium,
                          vertical: Dimensions.boxHeight16, // Larger padding
                        ),
                        border: InputBorder.none,
                      ),
                      maxLines: null, // Allow multiple lines
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) {
                        // Optional: Update cubit on change if needed
                      },
                    ),
                  ),
                  BlocBuilder<UpdateCommentCubit, UpdateCommentState>(
                    builder: (context, updateState) {
                      bool isLoading = updateState is UpdateCommentLoading &&
                          updateState.commentId == comment.id;
                      return ValueListenableBuilder<TextEditingValue>(
                        valueListenable: editCommentController,
                        builder: (context, text, child) {
                          return IconButton(
                            onPressed: isLoading || text.text.isEmpty
                                ? null
                                : () {
                              context.read<UpdateCommentCubit>().updateComment(
                                commentId: comment.id,
                                commentContent: text.text,
                              );
                            },
                            icon: isLoading
                                ? SizedBox(
                              width: Dimensions.boxWidth20,
                              height: Dimensions.boxHeight20,
                              child: CircularProgressIndicator(
                                strokeWidth: Dimensions.borderWidth,
                                color: AppColors.secondaryColor,
                              ),
                            )
                                : Icon(
                              Icons.send,
                              color: text.text.isEmpty
                                  ? AppColors.greyColor
                                  : AppColors.secondaryColor,
                              size: Dimensions.iconSize,
                            ),
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                    onPressed: () {
                      onToggleEditComment(null, null);
                    },
                    icon: Icon(
                      Icons.cancel,
                      color: AppColors.errorColor,
                      size: Dimensions.iconSize,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}