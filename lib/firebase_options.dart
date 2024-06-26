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
    apiKey: 'AIzaSyDLtfkKyMO4KHQnxAPPDYNtDLRLBnanAmA',
    appId: '1:263068648149:web:9d3093226f5bc28617985c',
    messagingSenderId: '263068648149',
    projectId: 'police-d509c',
    authDomain: 'police-d509c.firebaseapp.com',
    storageBucket: 'police-d509c.appspot.com',
    measurementId: 'G-W0MNZS9F91',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDl46XJcHdw9qF6ayM4bxk0f-f9PKtkBTc',
    appId: '1:263068648149:android:e74e94af73151df617985c',
    messagingSenderId: '263068648149',
    projectId: 'police-d509c',
    storageBucket: 'police-d509c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAhZLd5XuXxexmOcvIDrB6XGp_maoTAtyY',
    appId: '1:263068648149:ios:e4bea8ddba80e57717985c',
    messagingSenderId: '263068648149',
    projectId: 'police-d509c',
    storageBucket: 'police-d509c.appspot.com',
    iosBundleId: 'com.example.notifi',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAhZLd5XuXxexmOcvIDrB6XGp_maoTAtyY',
    appId: '1:263068648149:ios:596150b00d45776717985c',
    messagingSenderId: '263068648149',
    projectId: 'police-d509c',
    storageBucket: 'police-d509c.appspot.com',
    iosBundleId: 'com.example.notifi.RunnerTests',
  );
}
