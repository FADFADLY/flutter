import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/features/auth/presentation/controller/cubits/forget_password_cubit/password_confirmation_cubit.dart';
import 'package:graduationproject/features/auth/presentation/views/widgets/confirmation_password_view_bloc_consumer.dart';

import '../../../../core/constants/strings.dart';

class ConfirmationPassword extends StatelessWidget {
  const ConfirmationPassword({super.key});

  static const routeName = Strings.confirmationPasswordViewRoute;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            PasswordConfirmationCubit(authRepo: getIt<AuthRepo>()),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: buildAppBar(
            context,
            title: "",
            navigateTo: Strings.loginViewRoute,
            backgroundColor: Colors.transparent,
          ),
          body: ConfirmationPasswordBlocConsumer(),
        ));
  }
}