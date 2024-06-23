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
    apiKey: 'AIzaSyCq2FqO7o2emzAsTzDp5MyZExMU1K6_qbg',
    appId: '1:212039029567:web:8d9930aab58f168261b98a',
    messagingSenderId: '212039029567',
    projectId: 'insta-clone-84807',
    authDomain: 'insta-clone-84807.firebaseapp.com',
    storageBucket: 'insta-clone-84807.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA1xi_4IzmtU3iT4BwZzWaZgbO9gzFHbZY',
    appId: '1:212039029567:android:b62bf627072e05b461b98a',
    messagingSenderId: '212039029567',
    projectId: 'insta-clone-84807',
    storageBucket: 'insta-clone-84807.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCAX14cCeSLgQvbqe0Y1d57CAAjTCMV1dY',
    appId: '1:212039029567:ios:fdf07058ba99132861b98a',
    messagingSenderId: '212039029567',
    projectId: 'insta-clone-84807',
    storageBucket: 'insta-clone-84807.appspot.com',
    iosBundleId: 'com.example.instaClone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCAX14cCeSLgQvbqe0Y1d57CAAjTCMV1dY',
    appId: '1:212039029567:ios:fdf07058ba99132861b98a',
    messagingSenderId: '212039029567',
    projectId: 'insta-clone-84807',
    storageBucket: 'insta-clone-84807.appspot.com',
    iosBundleId: 'com.example.instaClone',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCq2FqO7o2emzAsTzDp5MyZExMU1K6_qbg',
    appId: '1:212039029567:web:0ad574b5244792bd61b98a',
    messagingSenderId: '212039029567',
    projectId: 'insta-clone-84807',
    authDomain: 'insta-clone-84807.firebaseapp.com',
    storageBucket: 'insta-clone-84807.appspot.com',
  );
}
