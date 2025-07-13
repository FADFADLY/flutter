import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:graduationproject/features/community/presentation/view/widgets/post_card_skeleton.dart';
import '../../../../../core/constants/imports.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../blog/presentation/view/widgets/refresh_pump_heart_with_child.dart';
import '../../controller/cubits/get_comments_cubit.dart';
import '../../controller/cubits/get_posts_cubit.dart';
import '../../controller/cubits/vote_cubit.dart';
import '../../controller/cubits/store_comment_cubit.dart';
import '../../controller/cubits/update_comment_cubit.dart';
import '../../controller/cubits/delete_comment_cubit.dart';
import '../../controller/cubits/update_post_cubit.dart';
import 'post_card.dart';
import '../../../../../core/utils/app_color.dart';

class PostList extends StatelessWidget {
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

  const PostList({
    super.key,
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
    return CustomRefreshIndicator(
      onRefresh: () async => context.read<GetPostsCubit>().getPosts(),
      builder: (context, child, controller) => RefreshPumpHeartWithChild(
        showPumpHeart: controller.value > 0,
        offset: controller.value * Dimensions.boxHeight50,
        controller: controller,
        child: child,
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingMedium),
        child: Column(
          children: [
            SizedBox(height: Dimensions.boxHeight10),
            BlocListener<VoteCubit, VoteState>(
              listener: (context, state) {
                if (state is VoteError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.message,
                        textDirection: TextDirection.rtl,
                      ),
                      backgroundColor: AppColors.errorColor,
                    ),
                  );
                  context.read<GetPostsCubit>().getPosts();
                } else if (state is VoteLoaded) {
                  context.read<GetPostsCubit>().updatePollVote(
                        postId: state.postId,
                        optionId: state.optionId,
                      );
                }
              },
              child: BlocListener<StoreCommentCubit, StoreCommentState>(
                listener: (context, state) {
                  if (state is CommentError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.message,
                          textDirection: TextDirection.rtl,
                        ),
                        backgroundColor: AppColors.errorColor,
                      ),
                    );
                  } else if (state is CommentLoaded) {
                    onToggleCommentPost(null);
                    context.read<GetPostsCubit>().getPosts();
                  }
                },
                child: BlocListener<UpdateCommentCubit, UpdateCommentState>(
                  listener: (context, state) {
                    if (state is UpdateCommentError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message,
                            textDirection: TextDirection.rtl,
                          ),
                          backgroundColor: AppColors.errorColor,
                        ),
                      );
                    } else if (state is UpdateCommentLoaded) {
                      onToggleEditComment(null, null);
                      context
                          .read<GetCommentsCubit>()
                          .getComments(activeCommentPostId!);
                    }
                  },
                  child: BlocListener<DeleteCommentCubit, DeleteCommentState>(
                    listener: (context, state) {
                      if (state is DeleteCommentError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              state.message,
                              textDirection: TextDirection.rtl,
                            ),
                            backgroundColor: AppColors.errorColor,
                          ),
                        );
                      } else if (state is DeleteCommentLoaded) {
                        context
                            .read<GetCommentsCubit>()
                            .getComments(activeCommentPostId!);
                      }
                    },
                    child: BlocListener<UpdatePostCubit, UpdatePostState>(
                      listener: (context, state) {
                        if (state is UpdatePostError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                state.message,
                                textDirection: TextDirection.rtl,
                              ),
                              backgroundColor: AppColors.errorColor,
                            ),
                          );
                        } else if (state is UpdatePostLoaded) {
                          onToggleEditPost(null, null);
                          context.read<GetPostsCubit>().getPosts();
                        }
                      },
                      child: BlocBuilder<GetPostsCubit, GetPostsState>(
                        builder: (context, state) {
                          if (state is GetPostsLoading) {
                            return PostCardSkeleton();
                          } else if (state is GetPostsLoaded) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.posts.length,
                              itemBuilder: (context, index) {
                                final post = state.posts[index];
                                return PostCard(
                                  post: post,
                                  isExpanded: isExpanded,
                                  activeCommentPostId: activeCommentPostId,
                                  editingCommentId: editingCommentId,
                                  editingPostId: editingPostId,
                                  commentController: commentController,
                                  editCommentController: editCommentController,
                                  editPostController: editPostController,
                                  currentUserName: currentUserName,
                                  isLoadingUserName: isLoadingUserName,
                                  doesTextExceedTwoLines: doesTextExceedTwoLines,
                                  onToggleExpand: onToggleExpand,
                                  onToggleCommentPost: onToggleCommentPost,
                                  onToggleEditComment: onToggleEditComment,
                                  onToggleEditPost: onToggleEditPost,
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: Text(
                                S.of(context).no_data,
                                style: AppStyles.text16Regular,
                                textDirection: TextDirection.rtl,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}