import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/utils/dimensions.dart';
import 'package:graduationproject/generated/l10n.dart';

import '../../../../../core/constants/sensitive_strings.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  late PageController pageController;
  var currentPage = 0;

  @override
  void initState() {
    pageController = PageController();
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page!.round();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: OnBoardingPageView(
            pageController: pageController,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
            Dimensions.paddingLarge, // 20px متجاوب
            0,
            Dimensions.paddingLarge, // 20px متجاوب
            Dimensions.paddingXXLarge, // 30px متجاوب
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                DotsIndicator(
                  dotsCount: 4,
                  position: currentPage.toDouble(),
                  decorator: DotsDecorator(
                    color: AppColors.whiteColor.withOpacity(0.2), // استخدام opacity
                    activeColor: AppColors.whiteColor,
                    size: Size.square(Dimensions.dotSize), // 9px متجاوب
                    activeSize: Size(Dimensions.activeDotWidth, Dimensions.activeDotHeight), // 36x9px متجاوب
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall), // 10px متجاوب
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.borderRadiusSmall)), // 10px متجاوب
                    color: AppColors.backgroundColor, // استبدال 0xffD9D9D9
                  ),
                  child: IconButton(
                    onPressed: () {
                      if (currentPage == 3) {
                        CacheHelper.set(key: SensitiveStrings.isOnBoardingViewSeen, value: true);
                        Navigator.of(context).pushNamed(SelectionScreen.routeName);
                      } else {
                        CacheHelper.set(key: SensitiveStrings.isOnBoardingViewSeen, value: true);
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    icon: Icon(
                      Icons.arrow_forward,
                      color: AppColors.primaryColor, // استبدال 0xff295163
                      size: Dimensions.onboardingIconSize, // 36px متجاوب
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}