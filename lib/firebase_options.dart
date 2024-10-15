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
    apiKey: 'AIzaSyA8N3jt2YeG-i3hqDe6_mjqMjUUe5D1kbg',
    appId: '1:132699204875:web:244dcb908df32f8f2d460e',
    messagingSenderId: '132699204875',
    projectId: 'chem4u-796f6',
    authDomain: 'chem4u-796f6.firebaseapp.com',
    storageBucket: 'chem4u-796f6.appspot.com',
    measurementId: 'G-K3KDR07N61',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAFh1y3i9eQ7NJ27QRDdNWDwdUhzRJdnS4',
    appId: '1:132699204875:android:a6969c84d162cc072d460e',
    messagingSenderId: '132699204875',
    projectId: 'chem4u-796f6',
    storageBucket: 'chem4u-796f6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD-_tbGhtIOEeZSSxqe4Rsdny_VJcOQFfs',
    appId: '1:132699204875:ios:374d89d9ec23dd5b2d460e',
    messagingSenderId: '132699204875',
    projectId: 'chem4u-796f6',
    storageBucket: 'chem4u-796f6.appspot.com',
    iosBundleId: 'com.example.chemlabFlutterProject',
  );
}
