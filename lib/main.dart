import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:device_preview/device_preview.dart';
import 'config/app_config.dart';
import 'config/cache/cache_helper.dart';
import 'config/cache/secure_cache_helper.dart';
import 'core/helper_func/on_generate_route.dart';
import 'features/auth/DeciderView.dart';
import 'features/auth/presentation/views/selection_screen.dart';
import 'features/onboarding/presentation/views/on_boarding.dart';
import 'features/splash/presentation/views/splash_view.dart';
import 'generated/l10n.dart';
import 'no_internet_connection_view.dart';

Future<void> main() async {
  await initializeApp();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode, // Enable only in debug mode
      builder: (context) => const FadFadly(),
    ),
  );
}

class FadFadly extends StatefulWidget {
  const FadFadly({Key? key}) : super(key: key);

  @override
  State<FadFadly> createState() => _FadFadlyState();
}

class _FadFadlyState extends State<FadFadly> {
  StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();
    subscription = InternetConnection().onStatusChange.listen((status) {
      switch (status) {
        case InternetStatus.connected:
          setState(() {});
          break;
        case InternetStatus.disconnected:
          setState(() {});
          break;
      }
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392.7273, 856.7273),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return StreamBuilder<InternetStatus>(
          stream: InternetConnection().onStatusChange,
          initialData: InternetStatus.connected,
          builder: (context, snapshot) {
            final isConnected = snapshot.data == InternetStatus.connected;

            return MaterialApp(
              // Enable device preview locale and accessibility
              locale: DevicePreview.locale(context),
              builder: DevicePreview.appBuilder,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              initialRoute: InitialView.routeName,
              onGenerateRoute: onGenerateRoute,
              debugShowCheckedModeBanner: false,
              home: isConnected ? null : const NoInternetConnectionView(),
            );
          },
        );
      },
    );
  }
}