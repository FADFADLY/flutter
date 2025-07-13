import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../../../core/constants/imports.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/styles.dart';
import '../../controller/cubits/update_post_cubit.dart';

class PostEditField extends StatelessWidget {
  final TextEditingController editPostController;
  final int postId;
  final VoidCallback onCancel;

  const PostEditField({
    super.key,
    required this.editPostController,
    required this.postId,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: editPostController,
          style: AppStyles.text14Regular,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            hintText: S.of(context).edit_post_hint,
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
          ),
        ),
        SizedBox(height: Dimensions.boxHeight12),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BlocBuilder<UpdatePostCubit, UpdatePostState>(
              builder: (context, state) {
                bool isLoading = state is UpdatePostLoading && state.postId == postId;
                return ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                    if (editPostController.text.isNotEmpty) {
                      context.read<UpdatePostCubit>().updatePost(
                        postId: postId,
                        content: editPostController.text,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: AutoSizeText(S.of(context).please_enter_content),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                    ),
                  ),
                  child: isLoading
                      ? SizedBox(
                    width: Dimensions.boxWidth20,
                    height: Dimensions.boxHeight20,
                    child: CircularProgressIndicator(
                      strokeWidth: Dimensions.borderWidth,
                      color: AppColors.whiteColor,
                    ),
                  )
                      : AutoSizeText(
                    S.of(context).save,
                    style: AppStyles.text14Regular,
                  ),
                );
              },
            ),
            SizedBox(width: Dimensions.boxWidth10),
            ElevatedButton(
              onPressed: onCancel,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.errorColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                ),
              ),
              child: AutoSizeText(
                S.of(context).cancel,
                style: AppStyles.text14Regular,
              ),
            ),
          ],
        ),
      ],
    );
  }
}