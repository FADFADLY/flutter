import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduationproject/core/constants/imports.dart';

class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: const [
        OnBoardingViewBodyFirstScreen(),
        OnBoardingViewBodyScndScreen(),
        OnBoardingViewBodyThrdScreen(),
        OnBoardingViewBodyFourthScreen(),
      ],
    );
  }
}