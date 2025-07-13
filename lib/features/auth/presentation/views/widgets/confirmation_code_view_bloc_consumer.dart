import 'package:flutter/material.dart';
import 'package:graduationproject/core/constants/imports.dart';
import '../../../../../core/constants/strings.dart';
import '../../../../../generated/l10n.dart';
import '../../controller/cubits/forget_password_cubit/pin_code_cubit.dart';
import '../confirm_password.dart';

class ConfirmationCodeViewBlocConsumer extends StatelessWidget {
  const ConfirmationCodeViewBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PinCodeCubit, PinCodeState>(
      listener: (context, state) {
        if (state is VerificationSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: AutoSizeText(
              minFontSize: 0,
              S.of(context).done,
            ),
          ));
          Navigator.pushNamed(context, Strings.confirmationPasswordViewRoute);
        } else if (state is VerificationFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: AutoSizeText(
              minFontSize: 0,
              state.message,
            ),
          ));
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
            inAsyncCall: state is VerificationLoadingState,
            child: ConfirmationCodeViewBody());
      },
    );
  }
}