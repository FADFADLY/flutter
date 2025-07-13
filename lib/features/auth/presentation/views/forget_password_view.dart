import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/features/auth/presentation/controller/cubits/forget_password_cubit/enter_email_cubit.dart';
import 'package:graduationproject/features/auth/presentation/views/widgets/forget_password_view_bloc_consumer.dart';

import '../../../../core/constants/strings.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  static const routeName = Strings.forgetPasswordViewRoute;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EnterEmailCubit(authRepo: getIt<AuthRepo>()),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: buildAppBar(
          context,
          title: "",
          navigateTo: Strings.loginViewRoute,
          backgroundColor: Colors.transparent,
        ),
        body: ForgetPasswordViewBlocConsumer(),
        backgroundColor: AppColors.backgroundColor,
      ),
    );
  }
}