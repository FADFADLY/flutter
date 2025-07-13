import '../../../../../../core/constants/imports.dart';
import '../../../../../../core/utils/dimensions.dart';
import '../../controller/cubits/mood_entry/monthly_mood_entry_cubit.dart';

class TabButton extends StatelessWidget {
  const TabButton({
    super.key,
    required this.cubit,
  });

  final MonthlyMoodEntryCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MonthlyMoodEntryCubit, MonthlyMoodEntryState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: Dimensions.moodTrackerButtonWidth,
              height: Dimensions.buttonHeight40,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(AppColors.secondaryColor),
                ),
                onPressed: () {
                  cubit.updatePageIndex(0);
                },
                child: AutoSizeText(
                  minFontSize: 0,
                  S.of(context).month,
                  style: AppStyles.text14Regular.copyWith(color: AppColors.whiteColor),
                ),
              ),
            ),
            SizedBox(
              width: Dimensions.moodTrackerButtonWidth,
              height: Dimensions.buttonHeight40,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(AppColors.secondaryColor),
                ),
                onPressed: () {
                  cubit.updatePageIndex(1);
                },
                child: AutoSizeText(
                  minFontSize: 0,
                  S.of(context).week,
                  style: AppStyles.text14Regular.copyWith(color: AppColors.whiteColor),
                ),
              ),
            ),
            SizedBox(
              width: Dimensions.moodTrackerButtonWidth,
              height: Dimensions.buttonHeight40,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(AppColors.secondaryColor),
                ),
                onPressed: () {
                  cubit.updatePageIndex(2);
                },
                child: AutoSizeText(
                  minFontSize: 0,
                  S.of(context).notes,
                  style: AppStyles.text14Regular.copyWith(color: AppColors.whiteColor),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}