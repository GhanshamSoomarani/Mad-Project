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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyD7z29sImYzbJHUY2FUDrhxUreQ3szf2Ug',
    appId: '1:11623910997:web:f987198650a0146df08edc',
    messagingSenderId: '11623910997',
    projectId: 'semester6-2ce23',
    authDomain: 'semester6-2ce23.firebaseapp.com',
    storageBucket: 'semester6-2ce23.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDEKXl0If84mj-AqHESr3-OQscp-oO2QVk',
    appId: '1:11623910997:android:b82f2f275fa1277af08edc',
    messagingSenderId: '11623910997',
    projectId: 'semester6-2ce23',
    storageBucket: 'semester6-2ce23.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCfplGuzwMHNsOJZzdLcKuBaf9IhZOYplc',
    appId: '1:11623910997:ios:1be46864c943e1b7f08edc',
    messagingSenderId: '11623910997',
    projectId: 'semester6-2ce23',
    storageBucket: 'semester6-2ce23.appspot.com',
    iosBundleId: 'com.example.mad',
  );
}