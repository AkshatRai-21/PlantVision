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
    apiKey: 'AIzaSyDp0WRRHUzDaG-C66daa-gt7XfYmPEkmug',
    appId: '1:352410063104:web:b64fead2c54cd4137263e5',
    messagingSenderId: '352410063104',
    projectId: 'plantvision-d56aa',
    authDomain: 'plantvision-d56aa.firebaseapp.com',
    storageBucket: 'plantvision-d56aa.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDuTLWNHNPIY0um5K-6hdw4Yso0tEkY7-s',
    appId: '1:352410063104:android:13a86064a42c5c4d7263e5',
    messagingSenderId: '352410063104',
    projectId: 'plantvision-d56aa',
    storageBucket: 'plantvision-d56aa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAItfEDAl4598gL3KnkAVsFQV_tQ8xDCYM',
    appId: '1:352410063104:ios:4170d319de16ad4e7263e5',
    messagingSenderId: '352410063104',
    projectId: 'plantvision-d56aa',
    storageBucket: 'plantvision-d56aa.appspot.com',
    iosBundleId: 'com.example.myApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAItfEDAl4598gL3KnkAVsFQV_tQ8xDCYM',
    appId: '1:352410063104:ios:27909a90352677b67263e5',
    messagingSenderId: '352410063104',
    projectId: 'plantvision-d56aa',
    storageBucket: 'plantvision-d56aa.appspot.com',
    iosBundleId: 'com.example.myApp.RunnerTests',
  );
}
