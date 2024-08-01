// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBJh29S6xdxX6_FzNTWWg4lqQUbntB0GAY',
    appId: '1:987677309912:web:4ebbd4505fec6bcafe10ad',
    messagingSenderId: '987677309912',
    projectId: 'notedapp263',
    authDomain: 'notedapp263.firebaseapp.com',
    storageBucket: 'notedapp263.appspot.com',
    measurementId: 'G-LFRR09TF1Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC-EK_6sWYeqgMlihA70ykpV9zn-NnIS0s',
    appId: '1:987677309912:android:bfc24b9d99c070e8fe10ad',
    messagingSenderId: '987677309912',
    projectId: 'notedapp263',
    storageBucket: 'notedapp263.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB9ccYAeJKLwmqPKvhASjLnaQuthnQdzdc',
    appId: '1:987677309912:ios:fa0f8acf033639a8fe10ad',
    messagingSenderId: '987677309912',
    projectId: 'notedapp263',
    storageBucket: 'notedapp263.appspot.com',
    iosBundleId: 'com.example.expense',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB9ccYAeJKLwmqPKvhASjLnaQuthnQdzdc',
    appId: '1:987677309912:ios:795fe40e2f6536cdfe10ad',
    messagingSenderId: '987677309912',
    projectId: 'notedapp263',
    storageBucket: 'notedapp263.appspot.com',
    iosBundleId: 'com.example.expense.RunnerTests',
  );
}
