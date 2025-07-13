import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/constants/strings.dart';

import '../../DeciderView.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const routeName = Strings.loginViewRoute;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(
        getIt<AuthRepo>(),
      ),

        child: Scaffold(
          extendBodyBehindAppBar: true,
appBar: buildAppBar(context, title: "", navigateTo: InitialView.routeName, backgroundColor: Colors.transparent),
          body: SignInBodyBlocConsumer(),
          backgroundColor: AppColors.backgroundColor,
        ),

    );
  }
}