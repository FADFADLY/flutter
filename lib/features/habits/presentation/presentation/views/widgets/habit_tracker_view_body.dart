import 'package:flutter/material.dart';
import 'package:graduationproject/core/constants/imports.dart';
import '../../../../../../core/utils/dimensions.dart';
import '../../../../../../generated/assets.dart';
import '../relaxation_view.dart';
import '../tasks_view.dart';

class HabitTrackerViewBody extends StatelessWidget {
  const HabitTrackerViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(Dimensions.paddingLarge), // 20.w
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.habitTrackerTop,
                    fit: BoxFit.contain,
                    height: Dimensions.boxHeight200,
                    width: MediaQuery.of(context).size.width,
                  ),
                  SizedBox(height: Dimensions.boxHeight20), // 20.h
                  AutoSizeText(
                    minFontSize: 0,
                    S.of(context).lets_gain_healthy_habits,
                    textAlign: TextAlign.center,
                    style: AppStyles.text14Regular,
                  ),
                  SizedBox(height: Dimensions.boxHeight20), // 20.h
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: CustomButton(
                      onPressed: () {
                        Navigator.pushNamed(context, TasksView.routeName);
                      },
                      text: S.of(context).lets_start,
                      backgroundColor: Colors.amber,
                      style: AppStyles.buttonStyle,
                      textStyle: AppStyles.text18Button,
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(Dimensions.paddingLarge), // 20.w
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    height:  Dimensions.boxHeight200,
                    width: MediaQuery.of(context).size.width,
                    Assets.habitTrackerBottom,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: Dimensions.boxHeight20), // 20.h
                  AutoSizeText(
                    minFontSize: 0,
                    S.of(context).lets_see_how_you_relax,
                    textAlign: TextAlign.center,
                    style: AppStyles.text14Regular,
                  ),
                  SizedBox(height: Dimensions.boxHeight20), // 20.h
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: CustomButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RelaxationView.routeName);
                      },
                      text: S.of(context).lets_start,
                      backgroundColor: Colors.amber,
                      style: AppStyles.buttonStyle,
                      textStyle: AppStyles.text18Button,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}