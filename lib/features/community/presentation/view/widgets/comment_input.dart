import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../../../core/constants/imports.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/styles.dart';
import '../../controller/cubits/store_comment_cubit.dart';
import '../../controller/cubits/get_comments_cubit.dart';

class CommentInput extends StatelessWidget {
  final int postId;
  final TextEditingController commentController;

  const CommentInput({
    super.key,
    required this.postId,
    required this.commentController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.boxHeight12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: commentController,
              style: AppStyles.text14Regular,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: S.of(context).write_comment_hint,
                hintStyle: AppStyles.text14Regular,
                filled: true,
                fillColor: AppColors.greyLightColor.withOpacity(0.2),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingMedium,
                  vertical: Dimensions.boxHeight12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.borderRadiusXLarge),
                  borderSide: BorderSide(
                    color: AppColors.secondaryColor,
                    width: Dimensions.borderWidth,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.borderRadiusXLarge),
                  borderSide: BorderSide(
                    color: AppColors.secondaryColor.withOpacity(0.5),
                    width: Dimensions.borderWidth,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.borderRadiusXLarge),
                  borderSide: BorderSide(
                    color: AppColors.secondaryColor,
                    width: Dimensions.borderWidth15,
                  ),
                ),
                suffixIcon: BlocBuilder<StoreCommentCubit, StoreCommentState>(
                  builder: (context, commentState) {
                    bool isLoading =
                        commentState is CommentLoading && commentState.postId == postId;
                    return ValueListenableBuilder<TextEditingValue>(
                      valueListenable: commentController,
                      builder: (context, text, child) {
                        return IconButton(
                          onPressed: isLoading || text.text.isEmpty
                              ? null
                              : () {
                            context.read<StoreCommentCubit>().storeComment(
                              postId: postId,
                              commentContent: text.text,
                            );
                            context.read<GetCommentsCubit>().getComments(postId);
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
              ),
              onSubmitted: (value) {
                context.read<StoreCommentCubit>().storeComment(
                  postId: postId,
                  commentContent: value,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}