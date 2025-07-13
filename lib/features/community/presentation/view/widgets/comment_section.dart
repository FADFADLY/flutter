import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/constants/imports.dart';
import '../../../../../core/shared_widgets/empty_no_data.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../controller/cubits/get_comments_cubit.dart';
import '../../controller/cubits/store_comment_cubit.dart';
import 'comment_card.dart';
import 'comment_input.dart';
import 'comment_skeleton.dart';

class CommentSection extends StatelessWidget {
  final int postId;
  final TextEditingController commentController;
  final TextEditingController editCommentController;
  final int? editingCommentId;
  final String? currentUserName;
  final bool isLoadingUserName;
  final void Function(int?, String?) onToggleEditComment;

  const CommentSection({
    super.key,
    required this.postId,
    required this.commentController,
    required this.editCommentController,
    required this.editingCommentId,
    required this.currentUserName,
    required this.isLoadingUserName,
    required this.onToggleEditComment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<GetCommentsCubit, CommentsState>(
          builder: (context, commentsState) {
            if (commentsState is CommentsLoading && commentsState.postId == postId) {
              return Skeletonizer(
                enabled: true,
                child: Padding(
                  padding: EdgeInsets.only(top: Dimensions.boxHeight8),
                  child: CommentSkeleton(),
                ),
              );
            } else if (commentsState is CommentsLoaded && commentsState.postId == postId) {
              final comments = commentsState.response.data;
              return Column(
                children: [
                  SizedBox(height: Dimensions.boxHeight12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: comments.length,
                    itemBuilder: (context, commentIndex) {
                      final comment = comments[commentIndex];
                      return CommentCard(
                        comment: comment,
                        postId: postId,
                        editingCommentId: editingCommentId,
                        editCommentController: editCommentController,
                        currentUserName: currentUserName,
                        isLoadingUserName: isLoadingUserName,
                        onToggleEditComment: onToggleEditComment,
                      );
                    },
                  ),
                ],
              );
            } else if (commentsState is CommentsError && commentsState.postId == postId) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: Dimensions.boxHeight8),
                child: EmptyNoData(
                  height: Dimensions.boxHeight130,
                ),
              );
            }
            // Show skeleton loader for initial or unmatched state
            return Skeletonizer(
              enabled: true,
              child: Padding(
                padding: EdgeInsets.only(top: Dimensions.boxHeight8),
                child: CommentSkeleton(),
              ),
            );
          },
        ),
        CommentInput(
          postId: postId,
          commentController: commentController,
        ),
      ],
    );
  }
}