import 'package:graduationproject/core/constants/imports.dart';

import '../../controller/cubits/forget_password_cubit/enter_email_cubit.dart';

class ForgetPasswordViewBlocConsumer extends StatelessWidget {
  const ForgetPasswordViewBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EnterEmailCubit, EnterEmailState>(
      listener: (context, state) {
        if (state is ForgetPasswordSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: AutoSizeText(
                minFontSize: 0, S.of(context).code_sent_success),
          ));

          Navigator.pushNamed(context, ConfirmationCodeView.routeName);
        } else if (state is ForgetPasswordFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: AutoSizeText(
                minFontSize: 0,state.message),
          ));
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is ForgetPasswordLoadingState,
           child: const ForgetPasswordViewBody(),
        );
      },
    );
  }
}
//