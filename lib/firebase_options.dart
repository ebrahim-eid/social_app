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
    apiKey: 'AIzaSyD4wmYcv_P1a0s52jrO4tLHOZnVshlg5do',
    appId: '1:300185674739:web:a20de578881881ae19e886',
    messagingSenderId: '300185674739',
    projectId: 'social-app-f8ef2',
    authDomain: 'social-app-f8ef2.firebaseapp.com',
    storageBucket: 'social-app-f8ef2.appspot.com',
    measurementId: 'G-8T5879T9WR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBZHfzdXmxy17p6Evs40iPvc9HpvDgnCIU',
    appId: '1:300185674739:android:9a151ab210ba816f19e886',
    messagingSenderId: '300185674739',
    projectId: 'social-app-f8ef2',
    storageBucket: 'social-app-f8ef2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAI9hdqN9E1PEXj1wsfwLgzGyO09uds9l8',
    appId: '1:300185674739:ios:22bd8c79dc91ad5819e886',
    messagingSenderId: '300185674739',
    projectId: 'social-app-f8ef2',
    storageBucket: 'social-app-f8ef2.appspot.com',
    iosBundleId: 'com.example.socialApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAI9hdqN9E1PEXj1wsfwLgzGyO09uds9l8',
    appId: '1:300185674739:ios:0ff3c835e957c98719e886',
    messagingSenderId: '300185674739',
    projectId: 'social-app-f8ef2',
    storageBucket: 'social-app-f8ef2.appspot.com',
    iosBundleId: 'com.example.socialApp.RunnerTests',
  );
}
