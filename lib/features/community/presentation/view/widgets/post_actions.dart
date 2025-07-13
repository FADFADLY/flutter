import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../../../core/constants/imports.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/styles.dart';
import '../../../domain/entity/posts_data_entity.dart';
import '../../controller/cubits/reaction_cubit.dart';

class PostActions extends StatelessWidget {
  final PostDataEntity post;
  final int? activeCommentPostId;
  final void Function(int?) onToggleCommentPost;

  const PostActions({
    super.key,
    required this.post,
    required this.activeCommentPostId,
    required this.onToggleCommentPost,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReactionsCubit, PostsReactionState>(
      builder: (context, reactionState) {
        return Row(
          children: [
            SizedBox(width: Dimensions.boxWidth16),
            Icon(
              Icons.thumb_up_alt_outlined,
              size: Dimensions.iconSize,
              color: AppColors.secondaryColor,
            ),
            SizedBox(width: Dimensions.boxWidth5),
            AutoSizeText(
              post.reactionsCount.toString(),
              style: AppStyles.text14Regular.copyWith(color: AppColors.secondaryColor),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(width: Dimensions.boxWidth16),
            GestureDetector(
              onTap: () {
                onToggleCommentPost(
                    activeCommentPostId == post.id ? null : post.id);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.comment,
                    size: Dimensions.iconSize,
                    color: AppColors.secondaryColor,
                  ),
                  SizedBox(width: Dimensions.boxWidth5),
                  AutoSizeText(
                    post.commentsCount.toString(),
                    style: AppStyles.text14Regular
                        .copyWith(color: AppColors.secondaryColor),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}