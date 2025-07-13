import 'package:fl_chart/fl_chart.dart';
import 'package:graduationproject/core/shared_widgets/loading_widget.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/constants/imports.dart';
import '../../../../../../core/utils/dimensions.dart';
import '../../../../domain/repo/repo.dart';
import '../../controller/cubits/mood_entry/weakly_mood_entry_cubit.dart';
import 'calender_header.dart';

class Chart extends StatelessWidget {
  const Chart({super.key});

  double _dayToX(String day) {
    DateTime date = DateTime.parse(day);
    String dayName = DateFormat('EEE').format(date);
    const Map<String, double> dayMap = {
      'Sat': 1.0,
      'Sun': 2.0,
      'Mon': 3.0,
      'Tue': 4.0,
      'Wed': 5.0,
      'Thu': 6.0,
      'Fri': 7.0,
    };
    return dayMap[dayName] ?? 1.0;
  }

  double _emojiToY(String emoji) {
    const Map<String, double> emojiMap = {
      '😐': 1.0, // 😐 none
      '😠': 2.0, // 😠 anger
      '😄': 3.0, // 😄 joy
      '😢': 4.0, // 😢 sadness
      '❤':  5.0, // ❤️ love
      '😨': 6.0, // 😨 fear
      '🤗': 7.0, // 🤗 sympathy
      '😲': 8.0, // 😲 surprise
    };
    return emojiMap[emoji] ?? 1.0;
  }

  String _yToEmoji(double y) {
     Map<double, String> yToEmojiMap = {
      1.0: '😐', // 😐
      2.0: '😠', // 😠
      3.0: '😄', // 😄
      4.0: '😢', // 😢
      5.0: '❤',  // ❤️
      6.0: '😨', // 😨
      7.0: '🤗', // 🤗
      8.0: '😲', // 😲
    };
    return yToEmojiMap[y] ?? '😐';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = WeaklyMoodEntryCubit(
          moodTrackerRepo: getIt<MoodTrackerRepo>(),
        );
        int currentWeek = cubit.getWeekOfYear(DateTime.now());
        cubit.updateNewFocusedWeak(currentWeek);
        cubit.getMoods(weak: currentWeek.toString());
        return cubit;
      },
      child: BlocConsumer<WeaklyMoodEntryCubit, WeaklyMoodEntryState>(
        listener: (context, state) {
          if (state is WeaklyMoodEntryError) {
            print('Error: ${state.message}');
          }
        },
        builder: (context, state) {
          final cubit = context.read<WeaklyMoodEntryCubit>();

          List<FlSpot> spots = [];
          if (state is WeaklyMoodEntrySuccess) {
            Map<double, double> uniqueDays = {};
            for (var mood in cubit.moodList) {
              double x = _dayToX(mood.day);
              double y = _emojiToY(mood.moodValue);
              if (x >= 1 && y >= 1) {
                uniqueDays[x] = y;
              }
            }
            spots = uniqueDays.entries
                .map((entry) => FlSpot(entry.key, entry.value))
                .toList();
            spots.sort((a, b) => a.x.compareTo(b.x));
          }

          return Column(
            children: [
              CalendarHeader(
                isWeekly: true,
                focusedDate: cubit.newFocusedWeak ?? DateTime.now(),
                onDateChanged: (newFocusedWeak) {
                  cubit.updateNewFocusedWeak(
                      cubit.getWeekOfYear(newFocusedWeak));
                  cubit.getMoods(
                      weak: cubit.getWeekOfYear(newFocusedWeak).toString());
                },
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.45,
                padding: EdgeInsets.all(Dimensions.paddingExtraSmall),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius:
                  BorderRadius.circular(Dimensions.borderRadiusSmall),
                ),
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.paddingMedium),
                  child: state is WeaklyMoodEntryLoading
                      ? const Center(child: LoadingWidget())
                      : LineChart(
                    LineChartData(
                      borderData: FlBorderData(show: false),
                      gridData: const FlGridData(show: false),
                      clipData: const FlClipData.all(),
                      lineBarsData: [
                        LineChartBarData(
                          spots: spots,
                          isCurved: true,
                          belowBarData: BarAreaData(
                            show: true,
                            color: AppColors.secondaryColor
                                .withOpacity(0.5),
                          ),
                          curveSmoothness: 0.3,
                          dotData: const FlDotData(show: true),
                          color: AppColors.secondaryColor,
                        ),
                      ],
                      lineTouchData: LineTouchData(
                        enabled: true,
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipItems:
                              (List<LineBarSpot> touchedSpots) {
                            return touchedSpots.map((LineBarSpot spot) {
                              final emoji = _yToEmoji(spot.y);
                              return LineTooltipItem(
                                emoji,
                                AppStyles.text16Regular.copyWith(
                                  color: AppColors.whiteColor,
                                ),
                              );
                            }).toList();
                          },
                        ),
                        handleBuiltInTouches: true,
                      ),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            interval: 1,
                            showTitles: true,
                            reservedSize: Dimensions.fieldHeight,
                            getTitlesWidget: (value, meta) {
                              switch (value.toInt()) {

                                case 1:
                                  return const AutoSizeText('😐', minFontSize: 0); // 😐
                                case 2:
                                  return const AutoSizeText('😠', minFontSize: 0); // 😠
                                case 3:
                                  return const AutoSizeText('😄', minFontSize: 0); // 😄
                                case 4:
                                  return const AutoSizeText('😢', minFontSize: 0); // 😢
                                case 5:
                                  return const AutoSizeText('❤',  minFontSize: 0); // ❤️
                                case 6:
                                  return const AutoSizeText('😨', minFontSize: 0); // 😨
                                case 7:
                                  return const AutoSizeText('🤗', minFontSize: 0); // 🤗
                                case 8:
                                  return const AutoSizeText('😲', minFontSize: 0); // 😲
                                default:
                                  return const AutoSizeText('', minFontSize: 0);
                              }
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            interval: 1,
                            showTitles: true,
                            reservedSize: Dimensions.dropdownItemHeight,
                            getTitlesWidget: (value, meta) {
                              switch (value.toInt()) {
                                case 1:
                                  return AutoSizeText('Sat', style: AppStyles.text14Regular, minFontSize: 0);
                                case 2:
                                  return AutoSizeText('Sun', style: AppStyles.text14Regular, minFontSize: 0);
                                case 3:
                                  return AutoSizeText('Mon', style: AppStyles.text14Regular, minFontSize: 0);
                                case 4:
                                  return AutoSizeText('Tue', style: AppStyles.text14Regular, minFontSize: 0);
                                case 5:
                                  return AutoSizeText('Wed', style: AppStyles.text14Regular, minFontSize: 0);
                                case 6:
                                  return AutoSizeText('Thu', style: AppStyles.text14Regular, minFontSize: 0);
                                case 7:
                                  return AutoSizeText('Fri', style: AppStyles.text14Regular, minFontSize: 0);
                                default:
                                  return const AutoSizeText('', minFontSize: 0);
                              }
                            },
                          ),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      minX: 1,
                      maxX: 7,
                      minY: 1,
                      maxY: 8,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
