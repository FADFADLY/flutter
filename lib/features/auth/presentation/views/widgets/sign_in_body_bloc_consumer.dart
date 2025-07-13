import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/features/test/presentation/views/test_view.dart';
import '../../../../../../core/constants/strings.dart';

class SignInBodyBlocConsumer extends StatelessWidget {
  const SignInBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state is SignInSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: AutoSizeText(
              minFontSize: 0,
              S.of(context).login_success,
            ),
          ));
          Navigator.pushNamed(context, TestView.routeName);
        } else if (state is SignInFailureState) {
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
          inAsyncCall: state is SignInLoadingState ? true : false,
          child: LoginViewBody(),
        );
      },
    );
  }
}