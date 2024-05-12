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
    apiKey: 'AIzaSyAxGShLXS2Eob8Hv25GOPiOumcsBvXQLXM',
    appId: '1:973953721702:web:6f611b2dc5c99029e994a7',
    messagingSenderId: '973953721702',
    projectId: 'todolist-c50c5',
    authDomain: 'todolist-c50c5.firebaseapp.com',
    storageBucket: 'todolist-c50c5.appspot.com',
    measurementId: 'G-YKDFY17L21',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBPvxdpjrQXEk3hHza8A6ZK8bOp0EO258Q',
    appId: '1:973953721702:android:2adcb60ad5457551e994a7',
    messagingSenderId: '973953721702',
    projectId: 'todolist-c50c5',
    storageBucket: 'todolist-c50c5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDL5bUdqa5ZZgJnt2UszYYMTwXRM_z_dPw',
    appId: '1:973953721702:ios:f0c5b930b422179be994a7',
    messagingSenderId: '973953721702',
    projectId: 'todolist-c50c5',
    storageBucket: 'todolist-c50c5.appspot.com',
    iosBundleId: 'com.example.todolist',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDL5bUdqa5ZZgJnt2UszYYMTwXRM_z_dPw',
    appId: '1:973953721702:ios:c3b2fd77ee5788c3e994a7',
    messagingSenderId: '973953721702',
    projectId: 'todolist-c50c5',
    storageBucket: 'todolist-c50c5.appspot.com',
    iosBundleId: 'com.example.todolist.RunnerTests',
  );
}
