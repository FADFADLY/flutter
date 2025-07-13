import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/features/mood_tracker/presentation/presentation/views/widgets/daily_note.dart';
import 'package:graduationproject/features/mood_tracker/presentation/presentation/views/widgets/feeling_today.dart';
import 'package:graduationproject/features/mood_tracker/presentation/presentation/views/widgets/mood_selector.dart';
import 'package:graduationproject/features/mood_tracker/presentation/presentation/views/widgets/save_button.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../domain/repo/repo.dart';
import '../controller/cubits/mood_tracker/mood_tracker_cubit.dart';
import 'mood_tracker_view_by_date.dart';

class MoodTrackerView extends StatefulWidget {
  const MoodTrackerView({super.key});

  static const String routeName = '/mood_tracker_view';

  @override
  State<MoodTrackerView> createState() => _MoodTrackerViewState();
}

class _MoodTrackerViewState extends State<MoodTrackerView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoodTrackerCubit(
        moodTrackerRepo: getIt<MoodTrackerRepo>(),
      ),
      child: BlocConsumer<MoodTrackerCubit, MoodTrackerState>(
        listener: (context, state) {
          if (!mounted) return;

          if (state is MoodTrackerPostError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: AutoSizeText(
                  minFontSize: 0,
                  state.message,
                  textDirection: TextDirection.rtl,
                  style: AppStyles.text16Regular,
                ),
                backgroundColor: AppColors.errorColor,
              ),
            );
          }
          else if (state is MoodTrackerPostSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: AutoSizeText(
                    minFontSize: 0,
                    state.moodEntryEntity.message,
                    textDirection: TextDirection.rtl,
                    style: AppStyles.text16Regular,
                  ),
                  backgroundColor: AppColors.successColor,
                ),
              );
            });
            Navigator.pushNamed(
              context,
              MoodTrackerViewByDate.routeName
            );
          }
          else if (state is MoodTrackerPostLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: AutoSizeText(
                  minFontSize: 0,
                  S.of(context).loading,
                  textDirection: TextDirection.rtl,
                  style: AppStyles.text16Regular,
                ),
                backgroundColor: AppColors.primaryColor,
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<MoodTrackerCubit>();

          return Scaffold(
            appBar: buildAppBar(
              context,
              title: S.of(context).mood_tracker_title,
              navigateTo: '',
              backgroundColor: AppColors.secondaryColor,
            ),
            body: SingleChildScrollView(
              child: Form(
                key: cubit.formKey,
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.paddingMedium),
                  child: Column(
                    children: [
                      SizedBox(height: Dimensions.boxHeight15),
                      DailyNote(cubit: cubit),
                      SizedBox(height: Dimensions.boxHeight15),
                      SaveButton(cubit: cubit),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}