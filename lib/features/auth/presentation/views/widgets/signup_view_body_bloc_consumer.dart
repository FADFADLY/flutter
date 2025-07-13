import 'package:graduationproject/core/constants/imports.dart';
import '../../../../../core/constants/strings.dart';

class SignupViewBodyBlocBuilder extends StatelessWidget {
  const SignupViewBodyBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) async {
        if (state is SignupSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: AutoSizeText(
                minFontSize: 0,
                S.of(context).account_created_successfully,
              ),
              duration: const Duration(seconds: 2),
            ),
          );
          await Future.delayed(const Duration(seconds: 2));
          Navigator.pushNamed(context, Strings.loginViewRoute);
        } else if (state is SignupFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: AutoSizeText(
                minFontSize: 0,
                state.message,
              ),
            ),
          );
          print(state.message);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is SignupLoadingState,
          child: const RegisterScreenBody(),
        );
      },
    );
  }
}