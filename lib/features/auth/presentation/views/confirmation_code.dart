import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/features/auth/presentation/controller/cubits/forget_password_cubit/pin_code_cubit.dart';
import 'package:graduationproject/features/auth/presentation/views/widgets/confirmation_code_view_bloc_consumer.dart';

import '../../../../core/constants/strings.dart';
import 'confirm_password.dart';

class ConfirmationCodeView extends StatelessWidget {
  const ConfirmationCodeView({super.key});

  static const routeName = Strings.confirmationCodeViewRoute;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PinCodeCubit(authRepo: getIt<AuthRepo>()),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: buildAppBar(
            context,
            title: "",
            navigateTo: Strings.selectionScreenRoute,
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: AppColors.backgroundColor,
          body: ConfirmationCodeViewBlocConsumer(),
        ));
  }
}