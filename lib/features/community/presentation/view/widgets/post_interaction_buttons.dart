import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'dart:developer';
import '../../../../../core/constants/imports.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/styles.dart';
import '../../../domain/entity/posts_data_entity.dart';
import '../../controller/cubits/reaction_cubit.dart';
import '../../controller/cubits/get_posts_cubit.dart';
import '../../controller/cubits/store_comment_cubit.dart';
import '../../controller/cubits/get_comments_cubit.dart';

class PostInteractionButtons extends StatelessWidget {
  final PostDataEntity post;
  final int? activeCommentPostId;
  final void Function(int?) onToggleCommentPost;

  const PostInteractionButtons({
    super.key,
    required this.post,
    required this.activeCommentPostId,
    required this.onToggleCommentPost,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        BlocBuilder<ReactionsCubit, PostsReactionState>(
          builder: (context, reactionState) {
            bool isLoading =
                reactionState is PostsReactionLoading && reactionState.postId == post.id;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LikeButton(
                  onTap: (bool isLiked) async {
                    if (isLoading) return isLiked;
                    context.read<GetPostsCubit>().updatePostReaction(
                      post.id,
                      !post.reacted,
                      post.reactionsCount + (post.reacted ? -1 : 1),
                    );
                    await context
                        .read<ReactionsCubit>()
                        .reaction(postId: post.id, type: 'post');
                    return !post.reacted;
                  },
                  size: Dimensions.boxHeight25,
                  isLiked: post.reacted,
                  likeBuilder: (bool isLiked) {
                    return isLoading
                        ? SizedBox(
                      width: Dimensions.boxHeight20,
                      height: Dimensions.boxHeight20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.secondaryColor,
                      ),
                    )
                        : Icon(
                      post.reacted
                          ? Icons.thumb_up_alt
                          : Icons.thumb_up_alt_outlined,
                      color: AppColors.secondaryColor,
                      size: Dimensions.iconSize,
                    );
                  },
                ),
                Text(
                  S.of(context).like,
                  style: AppStyles.text14Regular
                      .copyWith(color: AppColors.secondaryColor),
                  textDirection: TextDirection.rtl,
                ),
              ],
            );
          },
        ),
        BlocBuilder<StoreCommentCubit, StoreCommentState>(
          builder: (context, commentState) {
            return InkWell(
              onTap: () {
                onToggleCommentPost(
                    activeCommentPostId == post.id ? null : post.id);
                if (activeCommentPostId != post.id) {
                  context.read<GetCommentsCubit>().getComments(post.id);
                }
              },
              child: Row(
                children: [
                  Icon(
                    Icons.comment,
                    size: Dimensions.iconSize,
                    color: AppColors.secondaryColor,
                  ),
                  SizedBox(width: Dimensions.boxHeight4),
                  Text(
                    S.of(context).comment,
                    style: AppStyles.text14Regular
                        .copyWith(color: AppColors.secondaryColor),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}