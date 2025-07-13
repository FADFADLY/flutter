import 'dart:developer';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../../../core/constants/imports.dart';
import '../../../../../core/constants/sensitive_strings.dart';
import '../../../../../core/shared_widgets/empty_no_data.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../generated/assets.dart';
import '../../../../blog/presentation/view/widgets/refresh_pump_heart_with_child.dart';
import '../../controller/cubits/comments_reaction_cubit.dart';
import '../../controller/cubits/delete_post_cubit.dart';
import '../../controller/cubits/get_posts_cubit.dart';
import '../../controller/cubits/reaction_cubit.dart';
import '../../controller/cubits/vote_cubit.dart';
import '../../controller/cubits/store_comment_cubit.dart';
import '../../controller/cubits/get_comments_cubit.dart';
import '../../controller/cubits/update_comment_cubit.dart';
import '../../controller/cubits/delete_comment_cubit.dart';
import '../../controller/cubits/update_post_cubit.dart';
import 'create_post_view.dart';
import '../../../domain/entity/attachment_entity.dart';
import '../../../domain/entity/comment_entity.dart';
import '../../../domain/entity/comment_user_entity.dart';
import '../../../../../config/cache/secure_cache_helper.dart';
import 'post_creation_input.dart';
import 'post_list.dart';

class CommunityViewBody extends StatefulWidget {
  const CommunityViewBody({super.key});

  @override
  State<CommunityViewBody> createState() => _CommunityViewBodyState();
}

class _CommunityViewBodyState extends State<CommunityViewBody> {
  bool isExpanded = false;
  String name = '';
  int? activeCommentPostId;
  int? editingCommentId;
  int? editingPostId;
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _editCommentController = TextEditingController();
  final TextEditingController _editPostController = TextEditingController();
  String? currentUserName;
  bool isLoadingUserName = true;

  bool _doesTextExceedTwoLines(String text, TextStyle style, double maxWidth) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 2,
      textDirection: TextDirection.rtl,
    )..layout(maxWidth: maxWidth);
    return textPainter.didExceedMaxLines;
  }

  @override
  void initState() {
    super.initState();
    _loadCurrentUserName();
  }

  Future<void> _loadCurrentUserName() async {
    final username = await SecureCacheHelper.getString(key: "user_name");
    setState(() {
      currentUserName = username?.trim();
      isLoadingUserName = false;
      if (currentUserName == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: AutoSizeText(
              S.of(context).user_data_load_error,
              textDirection: TextDirection.rtl,
            ),
            backgroundColor: AppColors.errorColor,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    _editCommentController.dispose();
    _editPostController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PostCreationInput(),
        Expanded(
          child: PostList(
            isExpanded: isExpanded,
            activeCommentPostId: activeCommentPostId,
            editingCommentId: editingCommentId,
            editingPostId: editingPostId,
            commentController: _commentController,
            editCommentController: _editCommentController,
            editPostController: _editPostController,
            currentUserName: currentUserName,
            isLoadingUserName: isLoadingUserName,
            doesTextExceedTwoLines: _doesTextExceedTwoLines,
            onToggleExpand: () => setState(() => isExpanded = !isExpanded),
            onToggleCommentPost: (int? postId) {
              setState(() {
                activeCommentPostId = postId;
                _commentController.clear();
                editingCommentId = null;
                _editCommentController.clear();
              });
            },
            onToggleEditComment: (int? commentId, String? commentBody) {
              setState(() {
                editingCommentId = commentId;
                if (commentId != null && commentBody != null) {
                  _editCommentController.text = commentBody;
                } else {
                  _editCommentController.clear();
                }
              });
            },
            onToggleEditPost: (int? postId, String? postContent) {
              setState(() {
                editingPostId = postId;
                if (postId != null && postContent != null) {
                  _editPostController.text = postContent;
                } else {
                  _editPostController.clear();
                }
              });
            },
          ),
        ),
      ],
    );
  }
}