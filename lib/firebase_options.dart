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
    apiKey: 'AIzaSyDXvBkbo2SIcMMEkuvkBtTW4MrTpMKM4Og',
    appId: '1:451526087052:web:8eff6b95e2de1e988d46a9',
    messagingSenderId: '451526087052',
    projectId: 'weather-89d58',
    authDomain: 'weather-89d58.firebaseapp.com',
    storageBucket: 'weather-89d58.firebasestorage.app',
    measurementId: 'G-GPC44WBNXS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCiGofIlKqQV9sdbz5jnsguMY9OVDeLQ-M',
    appId: '1:451526087052:android:8bad653e4cc3addc8d46a9',
    messagingSenderId: '451526087052',
    projectId: 'weather-89d58',
    storageBucket: 'weather-89d58.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCHaa_a9F9_4T49rMTfNu6AWbzhmOfYWs4',
    appId: '1:451526087052:ios:46ab6b8dd2e089da8d46a9',
    messagingSenderId: '451526087052',
    projectId: 'weather-89d58',
    storageBucket: 'weather-89d58.firebasestorage.app',
    iosBundleId: 'com.example.weather',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCHaa_a9F9_4T49rMTfNu6AWbzhmOfYWs4',
    appId: '1:451526087052:ios:46ab6b8dd2e089da8d46a9',
    messagingSenderId: '451526087052',
    projectId: 'weather-89d58',
    storageBucket: 'weather-89d58.firebasestorage.app',
    iosBundleId: 'com.example.weather',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDXvBkbo2SIcMMEkuvkBtTW4MrTpMKM4Og',
    appId: '1:451526087052:web:d8b33723763629f48d46a9',
    messagingSenderId: '451526087052',
    projectId: 'weather-89d58',
    authDomain: 'weather-89d58.firebaseapp.com',
    storageBucket: 'weather-89d58.firebasestorage.app',
    measurementId: 'G-7D70PFCKHF',
  );
}
