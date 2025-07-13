import '../../../../../../core/constants/imports.dart';
import '../../../../../../core/utils/dimensions.dart';

class CustomWeekDays extends StatelessWidget {
  const CustomWeekDays({super.key});

  @override
  Widget build(BuildContext context) {
    final days = [
      S.of(context).mon,
      S.of(context).tue,
      S.of(context).wed,
      S.of(context).thu,
      S.of(context).fri,
      S.of(context).sat,
      S.of(context).sun
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(days.length, (index) {
        BorderRadius borderRadius;
        if (index == 0) {
          borderRadius = BorderRadius.only(topLeft: Radius.circular(Dimensions.borderRadiusSmall));
        } else if (index == days.length - 1) {
          borderRadius = BorderRadius.only(topRight: Radius.circular(Dimensions.borderRadiusSmall));
        } else {
          borderRadius = BorderRadius.zero;
        }
        return Expanded(
          child: Container(
            height: Dimensions.boxHeight214,
            margin: EdgeInsets.symmetric(horizontal: Dimensions.paddingExtraSmall, vertical: 0.0),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: borderRadius,
            ),
            child: Center(
              child: AutoSizeText(
                minFontSize: 0,
                days[index],
                style: AppStyles.text12Bold.copyWith(color: AppColors.whiteColor),
              ),
            ),
          ),
        );
      }),
    );
  }
}