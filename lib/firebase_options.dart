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
    apiKey: 'AIzaSyCj5VOW-iNPVYvd1Qg369g_weXgtcvZZCc',
    appId: '1:69046775842:web:484927c78f834af27c9a7b',
    messagingSenderId: '69046775842',
    projectId: 'ghioon-d8894',
    authDomain: 'ghioon-d8894.firebaseapp.com',
    storageBucket: 'ghioon-d8894.appspot.com',
    measurementId: 'G-61H7N5T8ZQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDM4V9hvxC8IfEr8aGK1l87h6YJnAoD8PM',
    appId: '1:69046775842:android:8f2151eef02c1ec67c9a7b',
    messagingSenderId: '69046775842',
    projectId: 'ghioon-d8894',
    storageBucket: 'ghioon-d8894.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAZ4imgxZRx0A3EbgN3zS-vwggGBb32fAQ',
    appId: '1:69046775842:ios:c34d7ece8ed3284e7c9a7b',
    messagingSenderId: '69046775842',
    projectId: 'ghioon-d8894',
    storageBucket: 'ghioon-d8894.appspot.com',
    androidClientId: '69046775842-1hkcug6a8tmdnttk2tl50r1lsdttr2a8.apps.googleusercontent.com',
    iosClientId: '69046775842-7uletmtqgqg9vc7st4nna12p22p9flvj.apps.googleusercontent.com',
    iosBundleId: 'com.example.ghioonSeller',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAZ4imgxZRx0A3EbgN3zS-vwggGBb32fAQ',
    appId: '1:69046775842:ios:c34d7ece8ed3284e7c9a7b',
    messagingSenderId: '69046775842',
    projectId: 'ghioon-d8894',
    storageBucket: 'ghioon-d8894.appspot.com',
    androidClientId: '69046775842-1hkcug6a8tmdnttk2tl50r1lsdttr2a8.apps.googleusercontent.com',
    iosClientId: '69046775842-7uletmtqgqg9vc7st4nna12p22p9flvj.apps.googleusercontent.com',
    iosBundleId: 'com.example.ghioonSeller',
  );
}
