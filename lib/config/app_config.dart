import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../firebase_options.dart';
import '../core/services/custom_bloc_observer.dart';
import '../core/services/get_it_services.dart';
import '../core/services/hive_setup.dart';
import 'cache/cache_helper.dart';
import 'cache/secure_cache_helper.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await SecureCacheHelper.init();
  await initHive();
  Bloc.observer = CustomBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupGetIt();

}