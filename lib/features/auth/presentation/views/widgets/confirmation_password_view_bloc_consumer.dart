import 'package:flutter/material.dart';
import 'package:graduationproject/core/constants/imports.dart';
import '../../../../../core/constants/strings.dart';
import '../../../../../generated/l10n.dart';
import '../../controller/cubits/forget_password_cubit/password_confirmation_cubit.dart';

class ConfirmationPasswordBlocConsumer extends StatelessWidget {
  const ConfirmationPasswordBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PasswordConfirmationCubit,
        PasswordConfirmationState>(
      listener: (context, state) {
        if (state is PasswordConfirmationSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: AutoSizeText(
              minFontSize: 0,
              S.of(context).password_changed_success,
            ),
          ));
          Navigator.pushNamed(context, Strings.loginViewRoute);
        } else if (state is PasswordConfirmationFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: AutoSizeText(
              minFontSize: 0,
              state.msg,
            ),
          ));
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall:
          state is PasswordConfirmationLoadingState ? true : false,
          child: ConfirmationPasswordViewBody(),
        );
      },
    );
  }
}