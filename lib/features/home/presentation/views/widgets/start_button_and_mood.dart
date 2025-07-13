import 'package:graduationproject/features/mood_tracker/presentation/presentation/views/mood_tracker_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../../../../../core/constants/imports.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../core/utils/dimensions.dart';

class StartButtonMood extends StatelessWidget {
  const StartButtonMood({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSmall, vertical: Dimensions.paddingSmall),
      child: Container(
        width: double.infinity,
        height: Dimensions.boxHeight70,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium),
        ),
        child: Padding(
          padding: EdgeInsets.all(Dimensions.paddingMedium),
          child: Row(
            children: [
              SizedBox(
                height: Dimensions.fieldHeight,
                width: Dimensions.buttonWidth,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, MoodTrackerView.routeName);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        S.of(context).lets_start,
                        style: AppStyles.text18Button,
                        minFontSize: 0,
                      ),
                      SizedBox(width: Dimensions.paddingSmall),
                      SvgPicture.asset(
                        Assets.iconVector,
                        width: Dimensions.iconSize,
                        height: Dimensions.iconSize,
                      ),
                    ],
                  ),
                  style: AppStyles.buttonStyle,
                ),
              ),
              SizedBox(width: Dimensions.paddingLarge),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      S.of(context).track_mood_description,
                      style: AppStyles.text18SemiBold,
                      textAlign: TextAlign.center,
                      minFontSize: 0,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}