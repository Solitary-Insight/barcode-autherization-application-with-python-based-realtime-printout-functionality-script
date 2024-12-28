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
    apiKey: 'AIzaSyAA7G7D0RIrS10O8TiGaUPtpC6tLjTgowQ',
    appId: '1:746256240988:web:75100abc29804ad3a7b199',
    messagingSenderId: '746256240988',
    projectId: 'myfirebaseproject-860aa',
    authDomain: 'myfirebaseproject-860aa.firebaseapp.com',
    databaseURL: 'https://myfirebaseproject-860aa-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'myfirebaseproject-860aa.appspot.com',
    measurementId: 'G-PP1KDXJH02',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAKOF6pTkM9fyuuzdOPv77SbZP8Jn26hw8',
    appId: '1:746256240988:android:8635fe82a8840497a7b199',
    messagingSenderId: '746256240988',
    projectId: 'myfirebaseproject-860aa',
    databaseURL: 'https://myfirebaseproject-860aa-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'myfirebaseproject-860aa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA1AkAEZwhakfYqYSUm015DzwVDIcy05as',
    appId: '1:746256240988:ios:73de9a86b6b6fe00a7b199',
    messagingSenderId: '746256240988',
    projectId: 'myfirebaseproject-860aa',
    databaseURL: 'https://myfirebaseproject-860aa-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'myfirebaseproject-860aa.appspot.com',
    androidClientId: '746256240988-cirvgn2qpvkids6vu0rj9vlpvkdv0060.apps.googleusercontent.com',
    iosClientId: '746256240988-10s3032fhvigecpia60557vqrhmnss2i.apps.googleusercontent.com',
    iosBundleId: 'com.example.barcodeAuth',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA1AkAEZwhakfYqYSUm015DzwVDIcy05as',
    appId: '1:746256240988:ios:73de9a86b6b6fe00a7b199',
    messagingSenderId: '746256240988',
    projectId: 'myfirebaseproject-860aa',
    databaseURL: 'https://myfirebaseproject-860aa-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'myfirebaseproject-860aa.appspot.com',
    androidClientId: '746256240988-cirvgn2qpvkids6vu0rj9vlpvkdv0060.apps.googleusercontent.com',
    iosClientId: '746256240988-10s3032fhvigecpia60557vqrhmnss2i.apps.googleusercontent.com',
    iosBundleId: 'com.example.barcodeAuth',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAA7G7D0RIrS10O8TiGaUPtpC6tLjTgowQ',
    appId: '1:746256240988:web:2881135a2d4cf222a7b199',
    messagingSenderId: '746256240988',
    projectId: 'myfirebaseproject-860aa',
    authDomain: 'myfirebaseproject-860aa.firebaseapp.com',
    databaseURL: 'https://myfirebaseproject-860aa-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'myfirebaseproject-860aa.appspot.com',
    measurementId: 'G-8ZJB8YSEF2',
  );

}