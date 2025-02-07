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
    apiKey: 'AIzaSyCCjQRTRYzedDVAww8Ltdd6c9KZipaytrw',
    appId: '1:369142788826:web:d0ffbd5e4cfefe84c62be3',
    messagingSenderId: '369142788826',
    projectId: 'bytelogik-3528c',
    authDomain: 'bytelogik-3528c.firebaseapp.com',
    storageBucket: 'bytelogik-3528c.firebasestorage.app',
    measurementId: 'G-7QLG5X36QF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAQyirBAIhDjmmsaSzOIvfp2_wlRQ24sMA',
    appId: '1:369142788826:android:9fae84e9128a9fcdc62be3',
    messagingSenderId: '369142788826',
    projectId: 'bytelogik-3528c',
    storageBucket: 'bytelogik-3528c.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDNCYcootNE2sQhrlbun78KC8le_e4wJ7A',
    appId: '1:369142788826:ios:152a0b38714a0ebfc62be3',
    messagingSenderId: '369142788826',
    projectId: 'bytelogik-3528c',
    storageBucket: 'bytelogik-3528c.firebasestorage.app',
    iosBundleId: 'com.example.untitled',
  );
}
