import 'package:flutter/material.dart';
import 'package:graduationproject/features/mood_tracker/presentation/presentation/controller/cubits/mood_entry/notes_cubit.dart';
import 'package:intl/intl.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/shared_widgets/loading_widget.dart';
import 'package:graduationproject/core/utils/dimensions.dart';
import 'package:graduationproject/features/mood_tracker/domain/repo/repo.dart';
import 'package:graduationproject/features/mood_tracker/domain/entity/data_mood_entity.dart';

class Notes extends StatelessWidget {
  const Notes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit(moodTrackerRepo: getIt<MoodTrackerRepo>())
        ..getNotes(),
      child: BlocConsumer<NotesCubit, NotesState>(
        listener: (context, state) {
          if (state is NotesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: AutoSizeText(
                  minFontSize: 12,
                  state.errorMessage,
                  style: AppStyles.text16Regular.copyWith(color: Colors.white),
                ),
                backgroundColor: AppColors.errorColor,
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(Dimensions.paddingMedium),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<NotesCubit>();

          return CustomRefreshIndicator(
            onRefresh: () async {
              await cubit.getNotes();
              print("cubit.moodList : ${cubit.moodList.map((item) => item.mood)}");
            },
            builder: (BuildContext context, Widget child, IndicatorController controller) {
              return AnimatedBuilder(
                animation: controller,
                builder: (context, _) {
                  final offset = controller.value * Dimensions.boxHeight40;
                  final bool showPumpHeart = controller.value > 0 || state is NotesLoading;

                  return Column(
                    children: [

                      Expanded(
                        child: Transform.translate(
                          offset: Offset(0, offset),
                          child: child,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: cubit.moodList.isEmpty && state is NotesLoading
                ? const LoadingWidget()
                : cubit.moodList.isEmpty
                ? Center(
              child: Text(
                S.of(context).no_notes_recorded,
                style: AppStyles.text16Regular.copyWith(color: AppColors.greyColor),
              ),
            )
                : ListView.builder(
              itemCount: cubit.moodList.length,
              itemBuilder: (context, index) {
                final moodData = cubit.moodList[index];
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => MoodDetailsDialog(moodData: moodData),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingMedium,
                      vertical: Dimensions.paddingSmall,
                    ),
                    elevation: 2,
                    color: AppColors.backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(Dimensions.paddingMedium),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AutoSizeText(
                                minFontSize: 12,
                                DateFormat('EEE M/d/yyyy').format(moodData.entryDate),
                                style: AppStyles.text12Regular,
                              ),
                              Row(
                                children: [
                                  AutoSizeText(
                                    minFontSize: 12,
                                    maxFontSize: 16,
                                    moodData.mood,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppStyles.text12Regular.copyWith(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.boxHeight16),
                                  AutoSizeText(
                                    minFontSize: 12,
                                    moodData.feeling ?? S.of(context).no_feeling_recorded,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppStyles.text14Regular,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.boxHeight16),
                          AutoSizeText(
                            minFontSize: 12,
                            moodData.notes ?? S.of(context).no_notes_recorded,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.text14Regular.copyWith(
                              color: AppColors.greyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class MoodDetailsDialog extends StatelessWidget {
  final DataMoodEntity moodData;

  const MoodDetailsDialog({super.key, required this.moodData});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium),
      ),
      elevation: 5,
      backgroundColor: AppColors.whiteColor,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
          maxWidth: MediaQuery.of(context).size.width * 0.85,
        ),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium),
          boxShadow: [
            BoxShadow(
              color: AppColors.greyColor.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Padding(
              padding: EdgeInsets.fromLTRB(
                Dimensions.paddingMedium,
                Dimensions.paddingMedium,
                Dimensions.paddingMedium,
                Dimensions.paddingSmall,
              ),
              child: AutoSizeText(
                minFontSize: 14,
                maxLines: 2,
                DateFormat('EEEE, MMMM d, yyyy').format(moodData.entryDate),
                style: AppStyles.text16Regular.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingMedium,
                  vertical: Dimensions.paddingSmall,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Mood Section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.mood,
                          color: AppColors.primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: Dimensions.paddingSmall),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                minFontSize: 14,
                                maxLines: 1,

                                S.of(context).mood,

                                style: AppStyles.text16Regular.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              SizedBox(height: Dimensions.boxHeight4),
                              AutoSizeText(
                                minFontSize: 12,
                                moodData.mood,
                                style: AppStyles.text14Regular.copyWith(
                                  color: AppColors.greyColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.boxHeight12),
                    // Feeling Section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          color: AppColors.primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: Dimensions.paddingSmall),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                minFontSize: 14,
                                maxLines: 1,

                                S.of(context).feeling,
                                style: AppStyles.text16Regular.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              SizedBox(height: Dimensions.boxHeight4),
                              AutoSizeText(
                                minFontSize: 12,
                                moodData.feeling ?? S.of(context).no_feeling_recorded,
                                style: AppStyles.text14Regular.copyWith(
                                  color: AppColors.greyColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.boxHeight12),
                    // Notes Section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.note_alt_outlined,
                          color: AppColors.primaryColor,
                          size: Dimensions.iconSize24,
                        ),
                        SizedBox(width: Dimensions.paddingSmall),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                minFontSize: 14,
                                maxLines: 1,
                                S.of(context).notes,
                                style: AppStyles.text16Regular.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              SizedBox(height: Dimensions.boxHeight4),
                              AutoSizeText(
                                minFontSize: 12,
                                moodData.notes ?? S.of(context).no_notes_recorded,
                                style: AppStyles.text14Regular.copyWith(
                                  fontSize: 15,
                                  color: AppColors.greyColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Close Button
            Padding(
              padding: EdgeInsets.all(Dimensions.paddingMedium),
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingLarge,
                    vertical: Dimensions.paddingSmall,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                  ),
                ),
                child: AutoSizeText(
                  minFontSize: 14,
                  'إغلاق',
                  style: AppStyles.text16Regular.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
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