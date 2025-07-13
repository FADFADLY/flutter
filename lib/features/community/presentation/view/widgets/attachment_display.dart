import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../../../core/constants/imports.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/styles.dart';
import '../../../domain/entity/attachment_entity.dart';
import '../../../domain/entity/posts_data_entity.dart';
import '../../controller/cubits/vote_cubit.dart';
import 'image_popup.dart';
import 'pdf_popup.dart';
import 'audio_player_widget.dart';

class AttachmentDisplay extends StatelessWidget {
  final PostDataEntity post;

  const AttachmentDisplay({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
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

    if (attachmentUrl != null) {
      if (attachmentType == 'image') {
        return GestureDetector(
          onTap: () => showImagePopup(context, attachmentUrl!),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
            child: Hero(
              tag: attachmentUrl,
              child: Image.network(
                attachmentUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      } else if (attachmentType == 'file') {
        return GestureDetector(
          onTap: () {
            if (attachmentUrl!.isNotEmpty && Uri.parse(attachmentUrl).isAbsolute) {
              showPdfPopup(context, attachmentUrl);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: AutoSizeText(S.of(context).invalid_file_link)),
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.only(top: Dimensions.boxHeight10),
            child: Container(
              padding: EdgeInsets.all(Dimensions.paddingSmall),
              decoration: BoxDecoration(
                color: AppColors.greyLightColor,
                borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                border: Border.all(color: AppColors.secondaryColor),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.insert_drive_file,
                    color: AppColors.secondaryColor,
                    size: Dimensions.socialIconSize,
                  ),
                  SizedBox(width: Dimensions.boxWidth8),
                  Expanded(
                    child: AutoSizeText(
                      S.of(context).file,
                      style: AppStyles.text14Regular
                          .copyWith(color: AppColors.secondaryColor),
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else if (attachmentType == 'audio') {
        return AudioPlayerWidget(audioUrl: attachmentUrl!);
      }
    }

    if (attachmentType == 'poll' &&
        post.attachment is AttachmentEntity &&
        (post.attachment as AttachmentEntity).options != null) {
      return BlocBuilder<VoteCubit, VoteState>(
        builder: (context, voteState) {
          final options = (post.attachment as AttachmentEntity)
              .options!
              .where((option) => option != null)
              .toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: options.asMap().entries.map<Widget>((entry) {
              final index = entry.key;
              final option = entry.value;
              final isLoading = voteState is VoteLoading &&
                  voteState.postId == post.id &&
                  voteState.optionId == option.id;
              final num percentage = option.percentage ?? 0.0;
              final progressValue = (percentage / 100).clamp(0.0, 1.0);

              return Padding(
                padding: EdgeInsets.only(top: Dimensions.boxHeight8),
                child: GestureDetector(
                  onTap: option.voted || isLoading
                      ? null
                      : () {
                    context.read<VoteCubit>().vote(
                      postId: post.id,
                      optionId: option.id,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: Dimensions.boxHeight10,
                      horizontal: Dimensions.paddingMedium,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          option.voted
                              ? AppColors.secondaryColor.withOpacity(0.3)
                              : AppColors.greyLightColor.withOpacity(0.1),
                          Colors.transparent,
                        ],
                        stops: [progressValue, progressValue],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                      ),
                      borderRadius:
                      BorderRadius.circular(Dimensions.borderRadiusMediumLarge),
                      border: Border.all(
                        color: option.voted
                            ? AppColors.secondaryColor
                            : AppColors.greyLightColor,
                        width: option.voted ? Dimensions.borderWidth15 : Dimensions.borderWidth,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.greyLightColor.withOpacity(0.1),
                          blurRadius: Dimensions.boxHeight4,
                          offset: Offset(0, Dimensions.boxHeight2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        isLoading
                            ? SizedBox(
                          width: Dimensions.boxWidth20,
                          height: Dimensions.boxHeight20,
                          child: CircularProgressIndicator(
                            strokeWidth: Dimensions.borderWidth,
                            color: option.voted
                                ? AppColors.secondaryColor
                                : AppColors.greyColor,
                          ),
                        )
                            : Icon(
                          Icons.check_circle,
                          color: option.voted
                              ? AppColors.secondaryColor
                              : AppColors.greyColor,
                          size: Dimensions.iconSize,
                        ),
                        SizedBox(width: Dimensions.boxWidth8),
                        Expanded(
                          child: AutoSizeText(
                            option.option,
                            style: AppStyles.text14Regular.copyWith(
                              color: option.voted
                                  ? AppColors.secondaryColor
                                  : AppColors.greyColor,
                              fontWeight:
                              option.voted ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                        SizedBox(width: Dimensions.boxWidth8),
                        AutoSizeText(
                          '${option.percentage}%',
                          style: AppStyles.text12Regular.copyWith(
                            color: option.voted
                                ? AppColors.secondaryColor
                                : AppColors.greyColor,
                            fontWeight:
                            option.voted ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      );
    }

    return const SizedBox.shrink();
  }
}