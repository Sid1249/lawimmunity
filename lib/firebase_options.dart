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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAdJ_bwjkIlCnDMcz7xHMtZybLIjTOu4D0',
    appId: '1:1016256532710:android:2a2243f0d66e2e42472b27',
    messagingSenderId: '1016256532710',
    projectId: 'lawimmunity-2aa26',
    databaseURL: 'https://lawimmunity-2aa26-default-rtdb.firebaseio.com',
    storageBucket: 'lawimmunity-2aa26.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBrqz_mx3lIosQSEYKEshZqU-rbudAr1BQ',
    appId: '1:1016256532710:ios:9873bdb7af2df8ad472b27',
    messagingSenderId: '1016256532710',
    projectId: 'lawimmunity-2aa26',
    databaseURL: 'https://lawimmunity-2aa26-default-rtdb.firebaseio.com',
    storageBucket: 'lawimmunity-2aa26.appspot.com',
    androidClientId: '1016256532710-627g2kjkat56aht7j0nc19aofl9qlbpg.apps.googleusercontent.com',
    iosClientId: '1016256532710-3tgtbcdskoqqer098vo2oofkbshf4n7m.apps.googleusercontent.com',
    iosBundleId: 'com.future.apps.lawimmunity.lawimmunity',
  );
}
