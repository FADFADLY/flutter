import 'package:graduationproject/core/constants/imports.dart';
class SplashView extends StatelessWidget {


  const SplashView({super.key});
  static const routeName = 'splash';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE8EBF0),
      body: const SplashViewBody(),
    );
  }
}
