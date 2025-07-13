import 'package:graduationproject/core/shared_widgets/loading_widget.dart';
import 'package:graduationproject/features/mood_tracker/presentation/presentation/controller/cubits/mood_entry/monthly_mood_entry_cubit.dart';
import 'package:graduationproject/features/mood_tracker/presentation/presentation/views/widgets/page_view_builder_widget.dart';
import 'package:graduationproject/features/mood_tracker/presentation/presentation/views/widgets/tab_buttons.dart';
import '../../../../../core/constants/imports.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../domain/repo/repo.dart';

class MoodTrackerViewByDate extends StatefulWidget {
  const MoodTrackerViewByDate({super.key});

  static const String routeName = '/mood_tracker_view_by_date';

  @override
  State<MoodTrackerViewByDate> createState() => _MoodTrackerViewByDateState();
}

class _MoodTrackerViewByDateState extends State<MoodTrackerViewByDate> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MonthlyMoodEntryCubit(moodTrackerRepo: getIt<MoodTrackerRepo>()),
      child: BlocConsumer<MonthlyMoodEntryCubit, MonthlyMoodEntryState>(
        listener: (context, state) {
          if (state is MoodEntryError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: AutoSizeText(
                  minFontSize: 0,
                  state.message,
                  style: AppStyles.text16Regular,
                ),
                backgroundColor: AppColors.errorColor,
              ),
            );
          } else if (state is MoodEntrySuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: AutoSizeText(
                  minFontSize: 0,
                  S.of(context).data_loaded_successfully,
                  style: AppStyles.text16Regular,
                ),
                backgroundColor: AppColors.successColor,
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<MonthlyMoodEntryCubit>();
          return Scaffold(
            appBar: buildAppBar(
              context,
              title: S.of(context).mood_tracker_title,
              navigateTo: '',
              backgroundColor: AppColors.secondaryColor,
            ),
            body: Container(
              padding: EdgeInsets.all(Dimensions.paddingMedium),
              child: Column(
                children: [
                  SizedBox(height: Dimensions.boxHeight20),
                  TabButton(cubit: cubit),
                  SizedBox(height: Dimensions.boxHeight20),
                  state is MoodEntryLoading
                      ? SizedBox(
                    height: Dimensions.boxHeight300,
                    width: double.infinity,
                    child: const LoadingWidget(),
                  )
                      : PageViewBuilderWidget(pageController: cubit.pageController),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}