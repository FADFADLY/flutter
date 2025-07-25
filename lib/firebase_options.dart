// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD0-ynwbd9iBE80DSXvjaCJW1FHsa8tzQc',
    appId: '1:1032254050048:web:a8ba03b4737f8a57582de5',
    messagingSenderId: '1032254050048',
    projectId: 'graduation-project-edited',
    authDomain: 'graduation-project-edited.firebaseapp.com',
    storageBucket: 'graduation-project-edited.firebasestorage.app',
    measurementId: 'G-DSFHLT91MY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDz71BjaXrwC8fonBMNvzKJIOmitHuGds8',
    appId: '1:1032254050048:android:2320fdedc01cc0d3582de5',
    messagingSenderId: '1032254050048',
    projectId: 'graduation-project-edited',
    storageBucket: 'graduation-project-edited.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDHaHFLzyD7PW5Q-wSTEmdfcA5xQ7Fctyo',
    appId: '1:1032254050048:ios:11ba7746b4df0367582de5',
    messagingSenderId: '1032254050048',
    projectId: 'graduation-project-edited',
    storageBucket: 'graduation-project-edited.firebasestorage.app',
    iosBundleId: 'com.example.graduationproject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDHaHFLzyD7PW5Q-wSTEmdfcA5xQ7Fctyo',
    appId: '1:1032254050048:ios:11ba7746b4df0367582de5',
    messagingSenderId: '1032254050048',
    projectId: 'graduation-project-edited',
    storageBucket: 'graduation-project-edited.firebasestorage.app',
    iosBundleId: 'com.example.graduationproject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD0-ynwbd9iBE80DSXvjaCJW1FHsa8tzQc',
    appId: '1:1032254050048:web:2ebb7cba5af377ac582de5',
    messagingSenderId: '1032254050048',
    projectId: 'graduation-project-edited',
    authDomain: 'graduation-project-edited.firebaseapp.com',
    storageBucket: 'graduation-project-edited.firebasestorage.app',
    measurementId: 'G-NENM98HP4S',
  );
}
