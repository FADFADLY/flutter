import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/generated/assets.dart';

import '../../../../../../core/utils/dimensions.dart';
import '../../../../domain/entity/store_habits_response_entity.dart';

class ScoreViewBody extends StatelessWidget {
  final StoreHabitsResponseEntity? response;

  const ScoreViewBody({super.key, this.response});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Assets.imagesHabitTrackerScore,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          SizedBox(height: Dimensions.boxHeight30), // 30.h
          Text(
            '${S.of(context).test_result}: ${response?.data.score ?? 0} / ${response?.data.fullMark ?? 0}',
            style: AppStyles.text24SemiBold,
          ),
          SizedBox(height: Dimensions.boxHeight30), // 30.h
          AutoSizeText(
            minFontSize: 0,
            S.of(context).good_job_keep_going,
            textAlign: TextAlign.center,
            style: AppStyles.text24SemiBold,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}