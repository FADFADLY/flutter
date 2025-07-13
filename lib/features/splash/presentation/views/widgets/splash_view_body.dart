import 'package:graduationproject/core/constants/imports.dart';
class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  bool animationDelay = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 10), () {
      setState(() {
        animationDelay = true;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: screenHeight * 0.15),
        SvgPicture.asset(
          AssetsPath.splashScreenLogo,
        ),
        AnimatedContainer(
          duration: const Duration(seconds: 2),
          curve: Curves.bounceInOut,
          padding: animationDelay
              ? const EdgeInsets.only(top: 0)
              : EdgeInsets.only(top: screenHeight * 0.06),
          child: SvgPicture.asset(
            AssetsPath.splashScreenFadfadly,
          ),
        ),
        SvgPicture.asset(
          fit: BoxFit.fitWidth,
          AssetsPath.splashScreenFlowerSplash,
        ),
      ],
    );
  }
}
