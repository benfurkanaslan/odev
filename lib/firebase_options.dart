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
    apiKey: 'AIzaSyB91lc39Z1tvch_G7nIG1bM-COYq8KDK8Q',
    appId: '1:1033412378620:web:ee73ed7b6e82830e7d3c79',
    messagingSenderId: '1033412378620',
    projectId: 'odev-e1cbe',
    authDomain: 'odev-e1cbe.firebaseapp.com',
    storageBucket: 'odev-e1cbe.appspot.com',
    measurementId: 'G-YK25QBJ67D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBw_ef81mPoFZSyJFhXOpK1Dw1QEj3imi4',
    appId: '1:1033412378620:android:c7887e7051fac1a47d3c79',
    messagingSenderId: '1033412378620',
    projectId: 'odev-e1cbe',
    storageBucket: 'odev-e1cbe.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAGkrXI3KU8m74sqYuECiOgxcTfY6t6cnw',
    appId: '1:1033412378620:ios:a9f353b161ca29567d3c79',
    messagingSenderId: '1033412378620',
    projectId: 'odev-e1cbe',
    storageBucket: 'odev-e1cbe.appspot.com',
    iosClientId: '1033412378620-mpbr8gegm1cg2pdgi2i9ot57att6san3.apps.googleusercontent.com',
    iosBundleId: 'com.alvin.odev',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAGkrXI3KU8m74sqYuECiOgxcTfY6t6cnw',
    appId: '1:1033412378620:ios:a9f353b161ca29567d3c79',
    messagingSenderId: '1033412378620',
    projectId: 'odev-e1cbe',
    storageBucket: 'odev-e1cbe.appspot.com',
    iosClientId: '1033412378620-mpbr8gegm1cg2pdgi2i9ot57att6san3.apps.googleusercontent.com',
    iosBundleId: 'com.alvin.odev',
  );
}
