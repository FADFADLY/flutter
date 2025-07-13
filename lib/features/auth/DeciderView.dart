import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/features/test/presentation/views/test_view.dart';
import '../../config/cache/secure_cache_helper.dart';
import '../../core/constants/sensitive_strings.dart';
import '../../core/constants/strings.dart';
import '../../core/utils/dimensions.dart';
import '../home/presentation/views/NavBar.dart';

class InitialView extends StatefulWidget {
  static const routeName = Strings.initialViewRoute;

  const InitialView({Key? key}) : super(key: key);

  @override
  _InitialViewState createState() => _InitialViewState();
}

class _InitialViewState extends State<InitialView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkNavigationFlow(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Center(
          child: SpinKitPumpingHeart(
            color: AppColors.backgroundColor,
            size: Dimensions.loadingIndicatorSize, // 75px متجاوب
          ),
        ),
      ),
    );
  }

  Future<void> checkNavigationFlow(BuildContext context) async {
    bool isOnBoardingSeen =
        CacheHelper.getBool(key: SensitiveStrings.isOnBoardingViewSeen) ?? false;

    if (!isOnBoardingSeen) {
      Navigator.of(context).pushNamed(OnBoardingView.routeName);
      return;
    }
    bool isLoggedIn =
        (await SecureCacheHelper.getString(key: SensitiveStrings.accessToken)) !=
            null;
    bool isTestFinished =
        CacheHelper.getBool(key: SensitiveStrings.isTestFinished) ?? false;
    if (isLoggedIn) {
      if (isTestFinished) {
        Navigator.of(context).pushNamed(BottomNavBar.routeName);
      } else {
        Navigator.of(context).pushNamed(TestView.routeName);
      }
    } else {
      Navigator.of(context).pushNamed(SelectionScreen.routeName);
    }
  }
}