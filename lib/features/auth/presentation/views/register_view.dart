import 'package:graduationproject/core/constants/imports.dart';

import '../../../../core/constants/strings.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  static const routeName = Strings.registerViewRoute;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(authRepository: getIt<AuthRepo>()),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: buildAppBar(context, title: "", navigateTo: Strings.selectionScreenRoute, backgroundColor: Colors.transparent),
        body: SignupViewBodyBlocBuilder(),
      ),
    );
  }
}